using Pkg.Artifacts

# Create a new hash for all files in assets
hash = create_artifact() do dir
    cp("assets/", joinpath(dir, "assets/"))
end

# For verification, can get the path of this hash
assets_artifact_path = artifact_path(hash) 

# Create tarball for this artifact hash
tarball_hash = archive_artifact(hash, "assets-artifact.tar.gz")

# Bind this artifact to Artifacts.toml in project's root
bind_artifact!(
    "../Artifacts.toml", 
    "assets-artifact", 
    hash, 
    download_info=[(
        "https://github.com/xKDR/NighttimeLights.jl/blob/artifacts/artifacts/assets-artifact.tar.gz",
        tarball_hash
    )]
)

