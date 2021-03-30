using Printf
include("UGM.jl")

# Create graph
E = [1 2
	2 3
	3 4
	4 5
	5 6
	6 7
	7 8
	8 9
	9 10
	10 1]
nEdges = size(E,1)

# Node Potentials (tied across groups)
phi1 = [.9 .1
	.9 .1
	.25 .75
	.9 .1
	.9 .1
	.25 .75
	.9 .1
	.25 .75
	.25 .75
	.9 .1]

# Edge potentials (all tied)
phi2 = repeat([2 1;1 2],1,1,nEdges)

# Compute normalizing constant
Z = computeZ(phi1,phi2,E)

# Example of computing potential for particular configurations
x = [1 2 1 2 1 2 1 2 1 2]
pTilde = unnormalizedProb(x,phi1,phi2,E)
@printf("Probability of alternating: %f\n",pTilde/Z)

x = [1 1 1 1 1 1 1 1 1 1]
pTilde = unnormalizedProb(x,phi1,phi2,E)
@printf("Probability of all-correct: %f\n",pTilde/Z)

x = [2 2 2 2 2 2 2 2 2 2]
pTilde = unnormalizedProb(x,phi1,phi2,E)
@printf("Probability of all-wrong: %f\n",pTilde/Z)

