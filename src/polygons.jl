function load_shapefile(path = "assets/districts.shp")
    """
    Provide path to shapefile
    """
    table           = Shapefile.Table(path)                        ## Reading the shapefile
    shapefile_df    = DataFrame(table)                             ## Converting to dataframe         
    geoms                        = Shapefile.shapes(table)         ## Reading shapes from the shapefile
    shapefile_df[!, "geometry"]  = geoms 
    return shapefile_df
end

function make_polygon(geometry::CoordinateSystem, coords)
    """
    This function Luxor polygon given a list of coordinates and a coordinate system. 
    """
    Drawing(geometry.height, geometry.width)
    # Make Luxor polygon from list of coordinates.
    array           = Array{Float16}[]          ## Declaring an empty array of Float32
    array           = coords[1]                 ## Accesssing n(th) polygon from the multipolgyon.
    points_luxor    = Luxor.Point[]             ## Declaring a Luxor.Point type variable
    for x in array
        push!(points_luxor, Luxor.Point(long_to_column(geometry, x[1]), lat_to_row(geometry, x[2]))) # make FLOAT16/INT16
            # We convert the long,lat to 'Luxor.Point' and store them in points_luxor 
    end
    poly = Luxor.poly(points_luxor, :stroke) 
    return poly
end


function make_polygons(geometry::CoordinateSystem, geoms)
    """Makes a list of Luxor polygons from list of list of coordinates."""
    coord       = GeoInterface.coordinates(geoms)
    polygons    = Any[]
    for x in coord
        push!(polygons, make_polygon(geometry, x))
    end
    return polygons
end

function polygon_mask(geometry::CoordinateSystem, shapefile_row)
    """
    shapefile_row can be selected using the following shapefile_row = shapefile_dataframe[:35, :]
    """
    geoms = shapefile_row.geometry
    polygons = make_polygons(geometry,geoms)
    points = zeros(geometry.height, geometry.width)
    for poly in polygons
        Boundary    = BoundingBox(poly)
        iend        = Int16(round(Boundary[2][2]))
        j           = Int16(round(Boundary[1][1]))
        jend        = Int16(round(Boundary[2][1]))
        i           = Int16(round(Boundary[1][2]))
        for e in i:iend
            for f in j:jend
                if Luxor.isinside(Luxor.Point(f, e), poly, allowonedge=true) == true
                    points[e,f] = 1
                end
            end
        end
    end
    return sparse(points)
end

"""
district = load_shapefile("districts.shp")
district_1 = district[:35, :]
polygon(district_1)
"""