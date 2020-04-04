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


input_sample = pd.DataFrame({'id': pd.Series(['HAss14'], dtype='object'), 'dna_sequence': pd.Series(['AATAAGAGATTATTACACGAAACTCAAGCACATGTAGATGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCTATGCCCATCATGCTCATCATGCAGCCGATGCCCATCACGCTCATCATGCAGCCGATGCCCATCATGCTCACCATGCAGCTGATGCTCATCAYGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCAYCATGCAGCTGATGCTCATCATGCTCATCATGCAGCYGATGCCCATCATGCTCATCATGCAGCYGATGCCCATCATGCTCATCATGCAGCTGATGCTCAYCATGCAGCTYATGCCCATCATGCTCATCATGCAGMTGATGCTCATCATGCAGCYGATGCTCACCATGCASCCGATGCTCATCATGCTCAYCATGCAGMCGATGCTCAYCATGCANCCGATGCTCATCATGCAGCCGATGCTCACCATGCAGCYGATGCTCACCATGCAACYGATGCTCATCATGCAGCYGATGCTCACCATGCAGCCGATGCTCACCATGCAGCCGATGCTCATCATGCAGCCGCACACCATGCAACTGATGCTCACCATGCAGCCGCACACCATGCAACCGATGCTC'], dtype='object'), 'aa_sequence': pd.Series(['NKRLLHETQAHVDDAHHAHHVADAHHAHHVADAHHAHHVADAHHAHHAADAHHAHHAADAHHAHHAAYAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAHHAADAHHAAXAHHAHHAXDAHHAADAHHAXDAHHAHHAXDAHHAXDAHHAADAHHAADAHHATDAHHAADAHHAADAHHAADAHHAAAHHATDAHHAAAHHATDA'], dtype='object'), 'Type_1': pd.Series(['9'], dtype='int64'), 'Type_2': pd.Series(['9'], dtype='int64'), 'Type_3': pd.Series(['9'], dtype='int64'), 'Type_4': pd.Series(['3'], dtype='int64'), 'Type_5': pd.Series(['0'], dtype='int64'), 'Type_6': pd.Series(['6'], dtype='int64'), 'Type_7': pd.Series(['6'], dtype='int64'), 'Type_8': pd.Series(['6'], dtype='int64'), 'Type_9': pd.Series(['3'], dtype='int64'), 'Type_10': pd.Series(['11'], dtype='int64'), 'Type_11': pd.Series(['0'], dtype='int64'), 'Type_12': pd.Series(['0'], dtype='int64'), 'Type_13': pd.Series(['0'], dtype='int64'), 'Type_14': pd.Series(['0'], dtype='int64'), 'Type_15': pd.Series(['0'], dtype='int64'), 'Type_16': pd.Series(['0'], dtype='int64'), 'Type_17': pd.Series(['0'], dtype='int64'), 'Type_18': pd.Series(['0'], dtype='int64'), 'Type_19': pd.Series(['5'], dtype='int64'), 'Type_20': pd.Series(['0'], dtype='int64'), 'Type_21': pd.Series(['0'], dtype='int64'), 'Type_22': pd.Series(['0'], dtype='int64'), 'Type_23': pd.Series(['0'], dtype='int64'), 'Type_24': pd.Series(['0'], dtype='int64'), 'workLiving': pd.Series(['4'], dtype='int64'), 'Address': pd.Series(['1'], dtype='object'), 'ResultBF': pd.Series(['1'], dtype='int64'), 'SpeciesmalaBF': pd.Series(['1'], dtype='int64'), 'PfPLDH': pd.Series(['1.0'], dtype='float64'), 'Parasitemia': pd.Series(['560.0'], dtype='float64'), 'Pf18sqPCR': pd.Series(['22.37'], dtype='float64'), 'qPCRcateg34': pd.Series(['1'], dtype='int64'), 'paradencateg': pd.Series(['3.0'], dtype='float64')})
output_sample = np.array([0])


def init():
    global model
    # This name is model.id of model that we want to deploy deserialize the model file back
    # into a sklearn model
    model_path = Model.get_model_path(model_name = 'AutoML217f4a22540')
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
