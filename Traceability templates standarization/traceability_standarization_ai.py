import openai
import pandas as pd
import numpy as np
import re
import ast
import os
import glob
pd.set_option('future.no_silent_downcasting', True)

#API key removed on purpose
openai.api_key = ""

# Load reference data
reference = pd.read_excel(r"C:\Users\Klaudia Gonciarz\Cocoasource SA\Cocoasource SA - Documents\Sustainability\Traceability\1. Fiches de traçabilité\24-25\Recap_CI_fiches_traca.xlsx", sheet_name="TOUT")
reference['Lots #'] = reference['Lots #'].astype(str).str.split('-')
reference = reference.explode('Lots #')
reference = reference.reset_index(drop=True)
reference = reference[['Lots #', 'OBL #', 'Supplier', 'Customer']]
reference['Lots #'] = reference['Lots #'].replace(['', 'nan'], np.nan)
reference = reference.dropna(subset=['Lots #'])
reference['Lots #'] = reference['Lots #'].astype(str).str.replace(r'\D', '', regex=True)
reference = reference.drop_duplicates(subset=['Lots #'])

def extract_relevant_table(data_file):
    df = pd.read_excel(data_file, header=None)
    start_row = df[df.apply(lambda row: row.astype(str).str.contains("Lot N°", case=False).any(), axis=1)].index[0]
    relevant_columns = df.columns[
        df.apply(lambda col: col.astype(str).str.contains(r'\S', na=False).any(), axis=0)
    ].tolist()

    relevant_columns = [col for col in relevant_columns if df[col].name != 'Unnamed: 0']

    relevant_df = pd.read_excel(data_file, skiprows=start_row, usecols=relevant_columns)

    if relevant_df.columns.notna().all():
        relevant_df = relevant_df.loc[:, ~relevant_df.columns.astype(str).str.contains(r'^Unnamed: 0')]

    relevant_df.columns = [col.replace("'", "") for col in relevant_df.columns]
    return relevant_df


data_folder = r"C:\Users\Klaudia Gonciarz\Cocoasource SA\Cocoasource SA - Documents\Sustainability\Traceability\1. Fiches de traçabilité\24-25\test"
output_file = r"C:\Users\Klaudia Gonciarz\Cocoasource SA\Cocoasource SA - Documents\Sustainability\Traceability\1. Fiches de traçabilité\24-25\output_test\output_test.xlsx"

def map_headers_to_column_names(data_file):
    headers = [
        "N° du lot", "date", "Date de livraison", "Code Plantation", "Farmer_id",
        "Section", "Nom et Prenoms", "# Sac", "Poids Net", "Prix Unitaire",
        "Montant", "Poids Cumul", "certification"
    ]
    relevant_df = extract_relevant_table(data_file)
    column_names = list(relevant_df.columns)

    prompt = f"""
    Given the following dataset columns: {column_names} and the required headers: {headers}, 
    please match the required headers to the names of the columns in the dataset. 
    Return a dictionary where keys are the required headers and the values are corresponding column names from the dataset.
    Here are the rules:
        - Only include the headers provided and ignore any extra fields.
        - Recognize "Code Plantation" as it ends with 'P1', 'P2', 'P3', or 'P4'.
        - Each header must match exactly one value in the output dictionary.
        - Do not use one column for two headers 
        - Only include headers that can be matched to column names from the dataset.
        - Do not use "None" as a header.
        - To match header "N° du lot" firstly focus on columns containing "LOT" or "LOT "
    """


    try:
        api_response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": prompt}]
        )
        if 'choices' in api_response and len(api_response['choices']) > 0:
            mapped_output = api_response['choices'][0]['message']['content'].strip()
            json_match = re.search(r'\{.*\}', mapped_output, re.DOTALL)
            if json_match:
                cleaned_output = json_match.group(0).replace("'", '"')  # Ensure valid JSON
                mapped_dict = ast.literal_eval(cleaned_output)
                return mapped_dict
            else:
                print(f"No valid JSON found in response for file {data_file}")
                return None
        else:
            print(f"Error: Unexpected API response for file {data_file}")
            return None
    except Exception as e:
        print(f"Error processing file {data_file}: {e}")

        return None

all_dfs = []

for data_file in glob.glob(os.path.join(data_folder, "*.xlsx")):
    relevant_df = extract_relevant_table(data_file)
    column_names = list(relevant_df.columns)
    dictionary = map_headers_to_column_names(data_file)
    if dictionary:
        dictionary = {v: k for k, v in dictionary.items()}

        df = extract_relevant_table(data_file)
        df = df.rename(columns=dictionary)

        headers = [
            "N° du lot", "date", "Date de livraison", "Code Plantation", "Farmer_id",
            "Section", "Nom et Prenoms", "# Sac", "Poids Net", "Prix Unitaire",
            "Montant", "Poids Cumul", "certification", "exporter", "client", "BL num"
        ]
        df = df[[col for col in headers if col in df.columns]]

        for col in headers:
            if col not in df.columns:
                df[col] = np.nan
        df = df[headers]

        df['N° du lot'] = df['N° du lot'].astype(str).str.replace(r'\.0$', '', regex=True)

        df = df.merge(reference[['Lots #', 'OBL #']], left_on='N° du lot', right_on='Lots #', how='left')
        df['BL num'] = df['BL num'].fillna(df['OBL #'])
        df = df.drop(columns=['Lots #', 'OBL #'])

        df = df.merge(reference[['Lots #', 'Supplier']], left_on='N° du lot', right_on='Lots #', how='left')
        df['exporter'] = df['exporter'].fillna(df['Supplier'])
        df = df.drop(columns=['Lots #', 'Supplier'])

        df = df.merge(reference[['Lots #', 'Customer']], left_on='N° du lot', right_on='Lots #', how='left')
        df['client'] = df['client'].fillna(df['Customer'])
        df = df.drop(columns=['Lots #', 'Customer'])

        df = df.dropna(subset=["Farmer_id", "Code Plantation", "Section"], how='all')

        all_dfs.append(df)

final_df = pd.concat(all_dfs, ignore_index=True)

final_df.to_excel(output_file, index=False)