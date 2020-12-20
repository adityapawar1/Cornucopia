#Does not work with Tenserflow 2.0 model type
import coremltools as ct
tf_model = "Models/model.h5"
mlmodel = ct.convert(tf_model)