##### Packages #####

## Import package manager
import Pkg

## Activate project
Pkg.activate(".")

## Add necessary packages to project
Pkg.add("Plots")
Pkg.add("DifferentialEquations")
Pkg.add("SparseArrays")
Pkg.add("DataFrames")
Pkg.add("CSV")

## check package status
Pkg.status()

## load packages
using Plots, DifferentialEquations, SparseArrays, DataFrames, CSV
