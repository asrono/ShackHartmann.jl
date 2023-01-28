using ShackHartmann
using Documenter

DocMeta.setdocmeta!(ShackHartmann, :DocTestSetup, :(using ShackHartmann); recursive=true)

makedocs(;
    modules=[ShackHartmann],
    authors="asrono <nielsbuijssen@hotmail.com> and contributors",
    repo="https://github.com/asrono/ShackHartmann.jl/blob/{commit}{path}#{line}",
    sitename="ShackHartmann.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://asrono.github.io/ShackHartmann.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/asrono/ShackHartmann.jl",
    devbranch="master",
)
