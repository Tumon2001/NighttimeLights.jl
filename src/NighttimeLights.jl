module NighttimeLights

using Dates
using ArchGDAL
using GeoArrays
using DataFrames
using Shapefile
using Luxor
using GeoInterface
using GeometricalPredicates
using ProgressMeter
using SparseArrays
using StatsBase
using Statistics
using Loess
using CubicSplines
using GLM
using RCall
using RecursiveArrayTools

# import date_generator, sparse_cube
export load_img, load_datacube, save_img, save_datacube, 
lat_to_row, row_to_lat, lat_to_row, long_to_column, translate_coordinate_system, Coordinate, CoordinateSystem, india,
polygon_mask, load_shapefile, mask_area, LAT, EW, NS, MODEL_EW, MODEL_NS, long_apply, cross_apply, apply_mask, view_img, bias_correction, bias_correction_datacube, outlier_mask, outlier_ts, linear_interpolation, threshold_datacube, background_noise_mask


include("data_io.jl")
include("view_image.jl")
include("coordinate_system.jl")
include("polygons.jl")
include("f_apply.jl")
include("date_generator.jl")
include("sparse_datacube.jl")
include("aggregate.jl")
include("other/nan_functions.jl")
include("other/detrend.jl")
include("other/weighted_mean.jl")
include("other/masks.jl")
include("data_cleaning/background_noise_removal.jl")
include("data_cleaning/outlier_removal.jl")
include("data_cleaning/bias_correction.jl")
include("data_cleaning/interpolation.jl")
include("other/rank_correlation.jl")
end
