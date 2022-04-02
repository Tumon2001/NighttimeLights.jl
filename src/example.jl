using Pkg.Artifacts

global radiance_datacube 
global clouds_datacube 
global mumbai_map 
""" 
The datacubes and the district level shapefile for Mumbai city are provided with the package as examples. These can be loaded using the function. The radiance datacube, cloud-free observations datacube and the shapefile of Mumbai districts are loaded as global variables. 

    """
    function load_example()
        println("Loading sample data")
        assets_path = joinpath(artifact"assets-artifact", "assets")
        map_path = joinpath(assets_path, "mumbai_map", "mumbai_districts.shp")
        radiance_jld_path = joinpath(assets_path, "mumbai_ntl", "datacube", "mumbai_radiance.jld")
        clouds_jld_path = joinpath(assets_path, "mumbai_ntl", "datacube", "mumbai_clouds.jld")
                
        global radiance_datacube = load_datacube(radiance_jld_path)
        global clouds_datacube = load_datacube(clouds_jld_path)
        global mumbai_map = load_shapefile(map_path)
        """
        i) Distict level shapefile of Mumbai is loaded as mumbai_map. 
        ii) Radiance datacube of Mumbai is loaded as radiance_datacube. 
        iii) Cloud-free observations data is loaded as clouds_datacube. 
        iv) MUMBAI_COORDINATE_SYSTEM should be used as the coordinate system. 
        """
        println("
        Follow the tutorial on:
        
        https://xkdr.github.io/NighttimeLights.jl/tutorial.html
        
        radiance_datacube, clouds_datacube and mumbai_map are loaded
        ")

end

