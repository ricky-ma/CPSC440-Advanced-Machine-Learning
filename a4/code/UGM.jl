# The code below defines an iterator that goes through all possible states
# Makes pretty code but NOT AT ALL EFFICIENT!!!
struct DiscreteStates
    d::Int
    k::Int
end
function Base.iterate(S::DiscreteStates, state=Int64(0))
	if state > S.k^S.d-1
		return nothing
	end

	s = state
	y = zeros(Int64,S.d)
	for pos in 1:S.d
        	y[pos] = 1+div(s,S.k^(S.d-pos))
        	s = mod(s,S.k^(S.d-pos))
	end
	return (y,state+1)
end



function unnormalizedProb(x,phi1,phi2,E)
    (d,k) = size(phi1)

    pTilde = 1
    for j in 1:d
        pTilde *= phi1[j,x[j]]
    end

    # Loops like this one would look nicer if I could do:
    # for (j1,j2) in E (and somehow get the edge number)
    for e in 1:nEdges
        j1 = E[e,1]
        j2 = E[e,2]
        pTilde *= phi2[x[j1],x[j2],e]
    end

    return pTilde
end

function computeZ(phi1,phi2,E)
    (d,k) = size(phi1)

    Z = 0
    for x in DiscreteStates(d,k)
        pTilde = unnormalizedProb(x,phi1,phi2,E)
        Z += pTilde
    end

    return Z
end
