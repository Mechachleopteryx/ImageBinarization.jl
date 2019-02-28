@testset "Niblack" begin

    for T in (Gray{N0f8}, Gray{N0f16}, Gray{Float32}, Gray{Float64})
        img = T.([i <= 25 && j <= 25 ? 0.7 : 1.0 for i = 1:50, j = 1:50])
        target_row = target_col = 13
        img[target_row,target_col] = 0.2

        img_bin = binarize(Niblack(), img)
        @test eltype(img) == eltype(img_bin)

        for i in 0:10:50, j in 0:10:50
            img₀ = circshift(img, (i,j))
            target_row₀ = (target_row + i) % 50
            target_col₀ = (target_col + j) % 50

            img_bin = binarize(Niblack(), img₀, w = 25, k = -2)
            @test sum(img_bin .== 0) == 1
            @test img_bin[target_row₀, target_col₀] == 0
        end
    end

end