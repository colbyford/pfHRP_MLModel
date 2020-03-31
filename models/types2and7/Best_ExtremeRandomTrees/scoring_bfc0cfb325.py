# ---------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# ---------------------------------------------------------
import json
import pickle
import numpy as np
import pandas as pd
import azureml.train.automl
from sklearn.externals import joblib
from azureml.core.model import Model

from inference_schema.schema_decorators import input_schema, output_schema
from inference_schema.parameter_types.numpy_parameter_type import NumpyParameterType
from inference_schema.parameter_types.pandas_parameter_type import PandasParameterType


input_sample = pd.DataFrame(data=[{'id': 'HAss14', 'dna_sequence': 'AATAAGAGATTATTACACGAAACTCAAGCACATGTAGATGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCTATGCCCATCATGCTCATCATGCAGCCGATGCCCATCACGCTCATCATGCAGCCGATGCCCATCATGCTCACCATGCAGCTGATGCTCATCAYGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCAYCATGCAGCTGATGCTCATCATGCTCATCATGCAGCYGATGCCCATCATGCTCATCATGCAGCYGATGCCCATCATGCTCATCATGCAGCTGATGCTCAYCATGCAGCTYATGCCCATCATGCTCATCATGCAGMTGATGCTCATCATGCAGCYGATGCTCACCATGCASCCGATGCTCATCATGCTCAYCATGCAGMCGATGCTCAYCATGCANCCGATGCTCATCATGCAGCCGATGCTCACCATGCAGCYGATGCTCACCATGCAACYGATGCTCATCATGCAGCYGATGCTCACCATGCAGCCGATGCTCACCATGCAGCCGATGCTCATCATGCAGCCGCACACCATGCAACTGATGCTCACCATGCAGCCGCACACCATGCAACCGATGCTC', 'aa_sequence': 'NKRLLHETQAHVDDAHHAHHVADAHHAHHVADAHHAHHVADAHHAHHAADAHHAHHAADAHHAHHAAYAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAAXAHHAHHAXDAHHAADAHHAXDAHHAHHAXDAHHAXDAHHAADAHHAADAHHATDAHHAADAHHAADAHHAADAHHAAAHHATDAHHAAAHHATDA', 'Type_1': 9, 'Type_2': 9, 'Type_3': 9, 'Type_4': 3, 'Type_5': 0, 'Type_6': 6, 'Type_7': 6, 'Type_8': 6, 'Type_9': 3, 'Type_10': 11, 'Type_11': 0, 'Type_12': 0, 'Type_13': 0, 'Type_14': 0, 'Type_15': 0, 'Type_16': 0, 'Type_17': 0, 'Type_18': 0, 'Type_19': 5, 'Type_20': 0, 'Type_21': 0, 'Type_22': 0, 'Type_23': 0, 'Type_24': 0, 'workLiving': 4, 'Address': '1', 'ResultBF': 1, 'SpeciesmalaBF': 1, 'PfPLDH': '1', 'Parasitemia': 560.0, 'Pf18sqPCR': 22.37, 'qPCRcateg34': 1, 'paradencateg': '3'}], columns=['id', 'dna_sequence', 'aa_sequence', 'Type_1', 'Type_2', 'Type_3', 'Type_4', 'Type_5', 'Type_6', 'Type_7', 'Type_8', 'Type_9', 'Type_10', 'Type_11', 'Type_12', 'Type_13', 'Type_14', 'Type_15', 'Type_16', 'Type_17', 'Type_18', 'Type_19', 'Type_20', 'Type_21', 'Type_22', 'Type_23', 'Type_24', 'workLiving', 'Address', 'ResultBF', 'SpeciesmalaBF', 'PfPLDH', 'Parasitemia', 'Pf18sqPCR', 'qPCRcateg34', 'paradencateg'])
output_sample = np.array([0])


def init():
    global model
    # This name is model.id of model that we want to deploy deserialize the model file back
    # into a sklearn model
    model_path = Model.get_model_path(model_name = 'AutoMLbfc0cfb325')
    model = joblib.load(model_path)


@input_schema('data', PandasParameterType(input_sample))
@output_schema(NumpyParameterType(output_sample))
def run(data):
    try:
        result = model.predict(data)
        return json.dumps({"result": result.tolist()})
    except Exception as e:
        result = str(e)
        return json.dumps({"error": result})
