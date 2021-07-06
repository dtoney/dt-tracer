-- local Common = require("premake5_common")
-- local Libname = Common.Libname

--[[------------------------------------------------------------------------------------------------
SimpleRayTracer project settings.
--------------------------------------------------------------------------------------------------]]
project("SimpleRayTracer")
    location(path.join("_build", os.target(), "apps/%{prj.name}"))
    targetdir("_output/%{cfg.longname}/apps/%{prj.name}")
    kind("ConsoleApp")
	characterset ("MBCS") -- multibyte
    files{"source/apps/%{prj.name}/**.*"}
    includedirs{
        "source/apps/**",
    }
    filter{"system:windows"}
        links{"winmm"}
