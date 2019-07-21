#!/usr/bin/env julia
__precompile__(true)

module RHEOS

# installed from Julia package repository
using InverseLaplace
using NLopt
using JLD2
import DSP.conv
# Base and stdlib imports
using Base.Cartesian
import Base.eltype
import SpecialFunctions.gamma
import Base: +, -, *
import DelimitedFiles: readdlm, writedlm
export constantcheck
using DataStructures
using FunctionWrappers: FunctionWrapper

######################################################################

# This defines the data type for all arrays, parameters and processing
# it is defined as a const to avoid performance penalties.
# See julia docs for more info on this.
const RheoFloat = Float64

# convenience data types used as in many function parameters
const IntOrNone = Union{Integer, Nothing}
const RheovecOrNone = Union{Vector{RheoFloat}, Nothing}

######################################################################
export RheoFloat

# definitions.jl
export RheoLogItem, RheoLog, rheologrun
export RheoTimeData, RheoTimeDataType, RheoFreqData, RheoFreqDataType, check_time_data_consistency
export LoadingType, strain_imposed, stress_imposed
export TimeDataType, time_only, strain_only, stress_only, strain_and_stress
export FreqDataType, invalid_freq_data, freq_only, with_modulus
export rheoconv,invLaplace

# IO.jl
export importcsv, exportcsv, savedata, loaddata, savemodel, loadmodel

# models.jl
export null_modulus
export SpringPot, Spring, DashPot
export FractionalMaxwell, FractionalMaxwellSpring, FractionalMaxwellDashpot, Maxwell
export FractionalKelvinVoigt, FractionalKVspring, FractionalKVdashpot, KelvinVoigt
export FractionalZener, FractionalSLS, SLS, FractionalJeffreys, Jeffreys
export FractionalSpecial
export JeffreysPT
export SLS2, PowerLawPlateau

# datagen.jl
export timeline
export strainfunction, stressfunction
export hstep, ramp, stairs, square, sawtooth, triangle
export frequencyspec

# processing.jl
export resample, cutting, smooth, extract
export modelfit, modelpredict, modelstepfit, modelsteppredict
export dynamicmodelfit, dynamicmodelpredict

######################################################
# bundled dependencies from rheos-cambridge forked repos
MittLeffLiteDir = joinpath(@__DIR__, "..", "deps", "MittLeffLite", "MittLeffLite.jl")
include(MittLeffLiteDir)
FastConvDir = joinpath(@__DIR__, "..", "deps", "FastConv", "FastConv.jl")
include(FastConvDir)

include("base.jl")
include("definitions.jl")
include("IO.jl")
include("modeldatabase.jl")
include("datagen.jl")
include("processing.jl")
######################################################
end
