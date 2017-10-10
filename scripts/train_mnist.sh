#!/bin/bash

java -Xmx5g -cp ${WEKA_HOME}/weka.jar weka.Run \
     .Dl4jMlpClassifier \
     -S 1 \
     -iterator "weka.dl4j.iterators.ImageDataSetIterator -height 28 -imagesLocation /home/tak/WaikatoProjects/wekaDeeplearning4j/datasets/nominal/mnist-minimal -numChannels 1 -bs 1 -width 28" \
     -normalization "Standardize training data" \
     -layer "weka.dl4j.layers.ConvolutionLayer -nFilters 32 -activation \"weka.dl4j.activations.ActivationReLU \" -adamMeanDecay 0.9 -adamVarDecay 0.999 -biasInit 1.0 -l1Bias 0.0 -l2Bias 0.0 -blr 0.01 -mode Truncate -cudnnAlgoMode PREFER_FASTEST -dist \"weka.dl4j.distribution.NormalDistribution -mean 0.001 -std 1.0\" -dropout 0.0 -epsilon 1.0E-6 -gradientNormalization None -gradNormThreshold 1.0 -kernelSizeX 3 -kernelSizeY 3 -L1 0.0 -L2 0.0 -name \"Convolution layer\" -lr 0.01 -momentum 0.9 -paddingX 0 -paddingY 0 -rho 0.0 -rmsDecay 0.95 -strideX 1 -strideY 1 -updater ADAM -weightInit XAVIER" \
     -layer "weka.dl4j.layers.SubsamplingLayer -mode Truncate -dropout 0.0 -eps 1.0E-8 -kernelSizeX 2 -kernelSizeY 2 -name \"Subsampling layer\" -paddingX 0 -paddingY 0 -pnorm 1 -poolingType MAX -strideX 1 -strideY 1" \
     -layer "weka.dl4j.layers.ConvolutionLayer -nFilters 16 -activation \"weka.dl4j.activations.ActivationReLU \" -adamMeanDecay 0.9 -adamVarDecay 0.999 -biasInit 1.0 -l1Bias 0.0 -l2Bias 0.0 -blr 0.01 -mode Truncate -cudnnAlgoMode PREFER_FASTEST -dist \"weka.dl4j.distribution.NormalDistribution -mean 0.001 -std 1.0\" -dropout 0.0 -epsilon 1.0E-6 -gradientNormalization None -gradNormThreshold 1.0 -kernelSizeX 3 -kernelSizeY 3 -L1 0.0 -L2 0.0 -name \"Convolution layer\" -lr 0.01 -momentum 0.9 -paddingX 0 -paddingY 0 -rho 0.0 -rmsDecay 0.95 -strideX 1 -strideY 1 -updater ADAM -weightInit XAVIER" \
      -layer "weka.dl4j.layers.SubsamplingLayer -mode Truncate -dropout 0.0 -eps 1.0E-8 -kernelSizeX 2 -kernelSizeY 2 -name \"Subsampling layer\" -paddingX 0 -paddingY 0 -pnorm 1 -poolingType MAX -strideX 1 -strideY 1" \
     -layer "weka.dl4j.layers.OutputLayer -activation \"weka.dl4j.activations.ActivationSoftmax \" -adamMeanDecay 0.9 -adamVarDecay 0.999 -biasInit 1.0 -l1Bias 0.0 -l2Bias 0.0 -blr 0.01 -dist \"weka.dl4j.distribution.NormalDistribution -mean 0.001 -std 1.0\" -dropout 0.0 -epsilon 1.0E-6 -gradientNormalization None -gradNormThreshold 1.0 -L1 0.0 -L2 0.0 -name \"Output layer\" -lr 0.01 -lossFn \"weka.dl4j.lossfunctions.LossMCXENT \" -momentum 0.9 -rho 0.0 -rmsDecay 0.95 -updater NESTEROVS -weightInit XAVIER" \
     -config "weka.dl4j.NeuralNetConfiguration -leakyreluAlpha 0.01 -maxNumLineSearchIterations 5 -minimize -numIterations 1 -algorithm STOCHASTIC_GRADIENT_DESCENT -stepFunction \"weka.dl4j.stepfunctions.NegativeGradientStepFunction \" -useRegularization" \
     -numEpochs 10 -queueSize 0 -batch-size 1 \
     -t ../datasets/nominal/mnist.meta.minimal.arff \
     -no-cv
