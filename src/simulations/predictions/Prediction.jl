
export Prediction

"""
    Prediction{CACHE} <: Simulation

A mutable struct that represents a prediction simulation.

# Fields
- `model::Sleipnir.Model`: The model used for the prediction.
- `glaciers::Vector{Sleipnir.AbstractGlacier}`: A vector of glaciers involved in the prediction.
- `parameters::Sleipnir.Parameters`: The parameters used for the prediction.
- `results::Vector{Results}`: A vector of results obtained from the prediction.
"""
mutable struct Prediction{CACHE, GLACIER <: Sleipnir.AbstractGlacier, PARAMS <: Sleipnir.Parameters} <: Simulation
    model::Sleipnir.Model
    cache::Union{CACHE, Nothing}
    glaciers::Vector{GLACIER}
    parameters::PARAMS
    results::Vector{Results}

    function Prediction(
        model::Sleipnir.Model,
        glaciers::Vector{<:Sleipnir.AbstractGlacier},
        parameters::Sleipnir.Parameters,
        results::Vector{Results},
    )
        CACHE = cache_type(model)
        GLACIER = eltype(glaciers)
        PARAMS = typeof(parameters)

        return new{CACHE, GLACIER, PARAMS}(model, nothing, glaciers, parameters, results)
    end
end


"""
    Prediction(model::Sleipnir.Model, glaciers::Vector{G}, parameters::Sleipnir.Parameters) where {G <: Sleipnir.AbstractGlacier}

Create a `Prediction` object using the given model, glaciers, and parameters.

# Arguments
- `model::Sleipnir.Model`: The model used for prediction.
- `glaciers::Vector{G}`: A vector of glacier objects, where each glacier is a subtype of `Sleipnir.AbstractGlacier`.
- `parameters::Sleipnir.Parameters`: The parameters used for the prediction.

# Returns
- `Prediction`: A `Prediction` object based on the input values.
"""
Prediction(model::Sleipnir.Model, glaciers::Vector{G}, parameters::Sleipnir.Parameters) where {G <: Sleipnir.AbstractGlacier} = Prediction(model, glaciers, parameters, Results[])

###############################################
################### UTILS #####################
###############################################

include("prediction_utils.jl")
