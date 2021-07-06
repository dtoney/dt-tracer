--[[----------------------------------------------------------------------------------------------------------
SimpleRayTracer Project Configuration.

This is the topmost Premake5 script. It sets up new actions, options, as well as the Solution settings.

Lower in this file, there are include() calls to add in extra projects to the solution.
------------------------------------------------------------------------------------------------------------]]

--local Common = require("premake5_common") -- TODO: will support organizing the framework

newaction{
    trigger = "clean",
    description = "Clean output folders.",
    onStart = function()
        print("Cleaning output folder(s).")
    end,
    execute = function()
        os.rmdir("_output")
        os.rmdir(path.join("_build", os.target()))
    end,
    onEnd = function()
        print("Done cleaning")
    end,
}

--[[----------------------------------------------------------------------------------------------------------
Solution and shared project settings.
------------------------------------------------------------------------------------------------------------]]

solution("SimpleRayTracer")
    location(path.join("_build", os.target()))
    configurations{"Release", "Hybrid", "Debug"}
    platforms{"x64"}
    cppdialect("C++17") -- Use C++17.
    language("C++")
    staticruntime("off") -- Use dynamic runtime.
    systemversion("10.0.17763.0") -- Use latest Windows SDK for VS 2017.
    startproject("SimpleRayTracer")
    debugdir("%{cfg.linktarget.directory}")
    defines{
        "NOMINMAX",
    }
    flags { "FatalWarnings" } -- Treat warnings as errors
    filter{"kind:SharedLib"}
        defines{
            "SRTRAC_DYNAMIC_LINKING",
            "SRTRAC_NONCLIENT_BUILD",
        }

    filter{"platforms:x64"}
        architecture("x86_64")

    -- Release configuration is the fastest.
    filter{"configurations:Release"}
        optimize("Full") -- Highest optimizations available.
        flags { "LinkTimeOptimization" } -- Enable link-time (i.e. whole program) optimizations.
        symbols("Off") -- Is not debuggable.
        runtime("Release")
        defines{
            "NDEBUG",
        }

    -- Hybrid configuration is between debug and release mode.
    filter{"configurations:Hybrid"}
        targetsuffix("_h")
        optimize("Off") -- No optimizations.
        symbols("On") -- Debuggable symbols.
        runtime("Release")
        defines{
            "NDEBUG",
            "HYBRID",
        }

    -- Debug configuration is slowest, but has most debug support.
    filter{"configurations:Debug"}
        targetsuffix("_d")
        optimize("Off") -- No optimizations.
        symbols("On") -- Debuggable symbols.
        runtime("Debug")
        defines{
            "DEBUG",
            "_DEBUG",
        }

    filter{"toolset:msc-v141"}
        defines{
            "_CRT_SECURE_NO_WARNINGS",
            "WIN32_MEAN_AND_LEAN",
            "WIN32_EXTRA_LEAN",
            "VC_EXTRA_LEAN",
            "NOMINMAX",
        }
        buildoptions{
            "/permissive-", -- Conformance mode enabled.
            "/Zc:twoPhase-",
        }

-- Include other Projects here.
include("premake5_apps.lua")
