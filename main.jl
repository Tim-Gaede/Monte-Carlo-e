using Formatting

function isDerangement(a::Array{Int64,1})
    # Based on the original array having all values
    # equal to their respective index
    # e.g. a_original == [1, 2, 3, 4, ..., length(a)]

    for i = 1 : length(a)
        if a[i] == i;    return false;    end
    end

    return true
end


function numDerangements(n::Int)
    if n == 2;    return 1;    end
    if n == 1;    return 0;    end

    return (n-1)*(numDerangements(n-1) + numDerangements(n-2))
end





function shuffle!(a::Array)

    n = length(a)
    for i = 1 : n

        r = rand(1:n)

        a[i], a[r] = a[r], a[i]
    end

end

function data_summing_randVars_to_1(N::Int)

    total_num_randVars = 0
    distr_num_randVars = [0    for i = 1 : 99]
    max = 2
    for n = 1 : N
        ∑ = 0.0
        cnt = 0
        while ∑ ≤ 1.0
            ∑ += rand()
            cnt += 1
        end

        if cnt > max;    max = cnt;    end

        distr_num_randVars[cnt] += 1
        total_num_randVars += cnt
    end


    distr_final = [0]
    for i = 2 : max
        push!(distr_final, distr_num_randVars[i])
    end

    distr_final, total_num_randVars / N
end

function distr_summing_randVars_to_1(N::Int)

    #total_num_randVars = 0
    distr_num_randVars = [0    for i = 1 : 99]
    max = 2
    for n = 1 : N
        ∑ = 0.0
        cnt = 0
        while ∑ ≤ 1.0
            ∑ += rand()
            cnt += 1
        end

        if cnt > max;    max = cnt;    end

        distr_num_randVars[cnt] += 1
    end

    ans = [0]
    for i = 2 : max
        push!(ans, distr_num_randVars[i])
    end
end

function main()
    println("-"^60, "\n")

    N = 18
    arr = [i    for i = 1 : N] # example of an array comprehension

    N❗ = factorial(N)
    ❗N = numDerangements(N)

    e_approx =  N❗ / ❗N
    e = exp(1)

    ways_fmd = format(N❗, commas=true)
    ders_fmd = format(❗N, commas=true)

    println("$N cards can be arranged in $N", "! = ", ways_fmd, " ways.")
    println("Of these, ", ders_fmd, " are derangements.")
    println("This is a ratio of ", e_approx)
    println("The ratio of this to the actual value of e is ", e_approx / e)
    println("\n"^2)





    numDers = 0
    TRIALS = 1_000_000
    trials_fmd = format(TRIALS, commas= true)

    targets_hit = ones(TRIALS)
    for cnt = 1 : TRIALS
        shuffle!(arr)
        if isDerangement(arr);    numDers += 1;    end

        targets_hit[rand(1:length(targets_hit))] = 0
    end

    println("For ", trials_fmd, " trials:\n")
    println("Derangements approximation to e:")
    ratio_der = TRIALS / numDers
    println(ratio_der, "\n", "ratio: ", 100.0 * ratio_der / e, "%")
    ratio_hits = TRIALS / sum(targets_hit)

    println("\n"^2)
    println("Targets approximation to e:")
    println(ratio_hits, "\n", "ratio: ", 100.0 * ratio_hits / e, "%")

    # Find the average trial length such that in each trial you
    # continuously add a random variable until the sum exceeds 1.
    # https://stats.stackexchange.com/questions/193990/approximate-e-using-monte-carlo-simulation


    trials = 10^10
    distr, avg = data_summing_randVars_to_1(trials)

    println("\n"^3)
    trials_fmd = format(trials, commas=true)
    println("For ", trials_fmd, " trials:")
    println("The average number of random numbers (from 0.0 to 1.0) needed ")
    println("To sum to unity:")
    println(avg)
    println("ratio: ", 100.0 * avg / e, "%")
    println("\n"^3)
    for i = 2 : length(distr)
        println(lpad(i, 2), " ", format(distr[i], commas=true))
    end



end
main()
