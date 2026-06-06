local _build_targets =
{
    "rive",
    "rive_harfbuzz",
    "rive_sheenbidi",
    "rive_yoga",
    "miniaudio",
    "rive_pls_renderer"
}

local _runtime_libs =
{
    "rive",
    "rive_harfbuzz",
    "rive_sheenbidi",
    "rive_yoga",
    "miniaudio",
    "rive_pls_renderer"
}

local function _config_name(package)
    return package:debug() and "debug" or "release"
end

local function _copy_match(pattern, dst)
    local files = os.files(pattern)
    if #files > 0 then
        os.cp(files, dst)
    end
end

local function _prepare_premake_script(sourcedir)
    local premake_v2 = path.join(sourcedir, "premake5_v2.lua")
    local premake = path.join(sourcedir, "premake5.lua")
    if os.isfile(premake_v2) and not os.isfile(premake) then
        os.mv(premake_v2, premake)
    end
end

local function _install_built_artifacts(package, outdir)
    os.cp(path.join(package:sourcedir(), "include"), package:installdir())
    if os.isdir(path.join(package:sourcedir(), "renderer", "include")) then
        os.cp(path.join(package:sourcedir(), "renderer", "include"), package:installdir("renderer"))
    end
    if os.isdir(path.join(package:sourcedir(), "decoders", "include")) then
        os.cp(path.join(package:sourcedir(), "decoders", "include"), package:installdir("decoders"))
    end
    os.mkdir(package:installdir("lib"))
    for _, libname in ipairs(_runtime_libs) do
        if package:is_plat("windows") then
            _copy_match(path.join(outdir, libname .. ".lib"), package:installdir("lib"))
            _copy_match(path.join(outdir, libname .. ".pdb"), package:installdir("lib"))
        else
            _copy_match(path.join(outdir, "lib" .. libname .. ".a"), package:installdir("lib"))
        end
    end
    assert(os.isfile(path.join(package:installdir("lib"), package:is_plat("windows") and "rive.lib" or "librive.a")),
        "rive-runtime main library not found in %s", outdir)
end

package("rive-runtime")
    set_homepage("https://github.com/rive-app/rive-runtime")
    set_description("Rive C++ runtime library built via premake5 build scripts.")

    add_urls("https://github.com/rive-app/rive-runtime.git")

    add_versions("0.1.0", "f102a08232bd0b18c3f7b2580ad0a80ea682a9d6")
    add_versions("0.1.1", "01e34aca09338321cb5e8fd55edd4e28cc24e027")
    add_versions("0.1.10", "0ff2a7bdf7e3a4f44a1b5d42f860be26058a31ef")
    add_versions("0.1.100", "c472dc609a31c160daf3136da01fb0a855e79eb5")
    add_versions("0.1.101", "64313541caeb1f38a299b89bc3cd8b5b42794fe5")
    add_versions("0.1.102", "5e9e4d55ee5a23d97b2c248b8e6c402d10e2e103")
    add_versions("0.1.103", "3f868558a4596e153afdb6bc3e8058596f0d971d")
    add_versions("0.1.104", "1ac816f809546cd140ae21fea00c5e39291fca0e")
    add_versions("0.1.105", "5a98d6a6e512ea06e6ec9cc02a6be38354f0d698")
    add_versions("0.1.106", "5360c834eac2adbdfc49c808d1b2a8c61b014bbf")
    add_versions("0.1.107", "2c0f7214fb443646a6c4509b156213e09f9cbb81")
    add_versions("0.1.108", "27aae9534ddbd971e136889b78b8a353bb2d0d6d")
    add_versions("0.1.11", "c66654139157078a1fb42fcbbcdd196f805b354b")
    add_versions("0.1.12", "5fbae935a48413adfc45ba9d9f6cf40f3dac4728")
    add_versions("0.1.13", "68d17599f3fdaa6aa3ace2db856ef91ba533744a")
    add_versions("0.1.14", "def43a5d0b318ee8b1aad50735f87628c5d04556")
    add_versions("0.1.15", "718983bba490930642d9e647f091b4af132a7c10")
    add_versions("0.1.16", "e95a283ff63c3abe9cdcaa23866b68ed0456cb69")
    add_versions("0.1.17", "0483f41fa59fad23208e4d59b28dfd83551ab706")
    add_versions("0.1.18", "3e00fa5e232a45ca42b32b0bba887c1965bad214")
    add_versions("0.1.19", "69130e2970a3b37cf09b59d97ec036cb7acd0888")
    add_versions("0.1.2", "dd633e5803050abbf9501c3e003e7b0927aa8205")
    add_versions("0.1.20", "f8e9129b1eb488b3e7b977acadc3cb4943986f6c")
    add_versions("0.1.21", "e6488f5d336aadecd150a0ed1c2e0aa2bfa8ddb2")
    add_versions("0.1.22", "c97e17d4c18849fca841b3a20863287815c4903a")
    add_versions("0.1.23", "8068970ecf450244af5c495c5c0707e691e3e9e8")
    add_versions("0.1.24", "c4771c17859aaaf4a1a84d1e5b52e3a2cfbcf5f8")
    add_versions("0.1.25", "ea22a841f7cdd5a4b307d34f54ef14025ed975ab")
    add_versions("0.1.26", "c8dce595fe73fe4e0e5dcbccd72a9cab684865a4")
    add_versions("0.1.27", "34b8501fd2051a7041fb2da1ab17ad2fdbd60d49")
    add_versions("0.1.28", "12bbf1847bfae9b6aa0ad59a2f8450b1259bd390")
    add_versions("0.1.29", "884be210b59f731ab58a6487f77f5e0e2f6979d1")
    add_versions("0.1.3", "40d15fae79f9c5d7205ae0f5f15facc89ab9c565")
    add_versions("0.1.30", "b8186987371d657c11c34f7dc6b05003e361f0e4")
    add_versions("0.1.31", "27d19d811554a59310350d8c9f25c4a282c6b481")
    add_versions("0.1.32", "ea1b789152f5fdc494a1996c2f730dc8a17caa82")
    add_versions("0.1.33", "083f42f78cfd658af200675908e9bd7a9cf5197d")
    add_versions("0.1.34", "bc44d66efe8094729b4fdbb24a5076149604700b")
    add_versions("0.1.35", "0116f21d29003881bf3b4fe5e5565b0d2b82c1a3")
    add_versions("0.1.36", "1ee20bc96c1d77e36e1e380b690408bd36165159")
    add_versions("0.1.37", "dc55c68e44e0a8dba26fdfcc0915fed50095a9c3")
    add_versions("0.1.38", "0d9683c62943aba3521a48da701db8ea97c5b59a")
    add_versions("0.1.39", "5d1ae16a46ea9368ed64180d581917fc61f17fa7")
    add_versions("0.1.4", "d6b161a95cb7f42f8bbe5b45f15af6dbdb99e912")
    add_versions("0.1.40", "ea7277bbe1d70583e7f7ebd594ddb0dc6fbc010d")
    add_versions("0.1.41", "6dc4817996cd2e87f3d8469833381eb55a5a8b94")
    add_versions("0.1.42", "099ecea527950b58f9b2eb6c269cd4b2743b6427")
    add_versions("0.1.43", "1a9e8802a68eb3468d6d0ef64006a651b8acfaee")
    add_versions("0.1.44", "c6936e3f2c9d9431efb0fb70bec94c77c399da72")
    add_versions("0.1.45", "184add8a69ced83df0bca9951517eaceda64c27e")
    add_versions("0.1.46", "6cd9a9556bf0006109803e3f3b377eee82244b14")
    add_versions("0.1.47", "858f62e74484215beff64df499f79b37d73d0304")
    add_versions("0.1.48", "557f43cf1356569e8471ebe843d5dbaef546b538")
    add_versions("0.1.49", "3a700d38f5685eeeebe7019be6c734afe502e376")
    add_versions("0.1.5", "d7b985a1f9c5b491f2b43603d20b851027878503")
    add_versions("0.1.50", "e161b05638eb14a02a1325e865ea3c277de71337")
    add_versions("0.1.51", "e031209510932a392451786322400afbffd94823")
    add_versions("0.1.52", "7f535b54c6d832e10b6094951d3035e05afe4579")
    add_versions("0.1.53", "04ee93e5254e1ed7175db5d71468881b6bcfe102")
    add_versions("0.1.54", "7bbdd0e316f748b9e26daebeaf9bfda9a644e284")
    add_versions("0.1.55", "23c275e1dc2183a6d917a95e1917424c1c8eb464")
    add_versions("0.1.56", "976914524346718580ec0cf8a82742f473a04873")
    add_versions("0.1.57", "e22de160f13cea6ebcf2d41622381ba65d1e01d2")
    add_versions("0.1.58", "b1b55911651478468148d50bd1547e0529c84923")
    add_versions("0.1.59", "435b6050abd4c202226ac7ff72d4533db54dd815")
    add_versions("0.1.6", "f84e3e1dbbd04ea40269ea788996361a0c1ae57b")
    add_versions("0.1.60", "cea70bc5be3c3229ea0aaf905d390f5d19dd2808")
    add_versions("0.1.61", "f072084aa3b9f69b3e9c5047ca2ae7b707169905")
    add_versions("0.1.62", "972e52893bf03fd26920d4d191d1a09c7e0b0fa5")
    add_versions("0.1.63", "43a7dfcd7f3458d19fe915b002f0b3e187d8c048")
    add_versions("0.1.64", "b25a32218c6308ac8dc4b1cb69df62de84d78ba4")
    add_versions("0.1.65", "309d275b5e555abf3b59c65edb8a2340eeb7d5f2")
    add_versions("0.1.66", "df2ce85eabdf65f11106f95a887cab07523d562d")
    add_versions("0.1.67", "d3322a58097595a2e9a3ba2f3982133f665e4145")
    add_versions("0.1.68", "e17418d6b9f853deb6b36059780476672ae4750d")
    add_versions("0.1.69", "43a61aeeb76a1cb34da93293ee322d25e8fda09f")
    add_versions("0.1.7", "afd596a8c6c0d5374c62dd142bce8044fdea6e08")
    add_versions("0.1.70", "b959ffcbde93aece43990a02cc94b63536b8cb0e")
    add_versions("0.1.71", "c162cb079aab4f66df21fa2a94d0b44da7003dfc")
    add_versions("0.1.72", "5be0882b933770cfc5a4dc2635c9d9493cffd543")
    add_versions("0.1.73", "8fb428d73a58631eeecb6137a9c41ac331b577f1")
    add_versions("0.1.74", "619d38c121884b32c8b4e59d2a2509f048e5fffe")
    add_versions("0.1.75", "ca601f7fd9a7bf282bd2dbc46481d98fd75c7478")
    add_versions("0.1.76", "4c5f98f687d38203aba042ecc0a9d9f199134937")
    add_versions("0.1.77", "bac728c01888ef76977f83a15943380a7372b173")
    add_versions("0.1.78", "a589e26c3b7cc92196d817e3bccd0e6352327414")
    add_versions("0.1.79", "b52604211f53cd6e47ed2cb7ed146db860f0f8b4")
    add_versions("0.1.8", "436ec88c4099a7a8ab913d5ab4e5075b10733b9a")
    add_versions("0.1.80", "069757f971707d6aaadaa411f6684ab1f08a565d")
    add_versions("0.1.81", "fa27433fd7bff818a883385a96bf61d5347f50d2")
    add_versions("0.1.82", "256822295bb84874b2f34ca1257975d10017a9cc")
    add_versions("0.1.83", "3f55fe92815c5c974fe044ca6ff21471298570b3")
    add_versions("0.1.84", "8e699d1be69176d60f2c6eac76bdd389e72ad0ad")
    add_versions("0.1.85", "e719b59b7659ab154455acab1bcc0db94ff21ff9")
    add_versions("0.1.86", "b7c3b9bbbc18982601f3d39ecf4f881ef530fd7a")
    add_versions("0.1.87", "86ac49e93480237e41228de9558abd1a529c4040")
    add_versions("0.1.88", "6fa4a524e276438dcf6823efb57fc06073850520")
    add_versions("0.1.89", "bd1ed346ff8dbdd40e78eceb5c752ac7cf5b44ad")
    add_versions("0.1.9", "1202128f0781682fa4735c3fcabfdf7e284b91d7")
    add_versions("0.1.90", "bdf73a3f6643250a97bdd4c0e505e40122ff42ec")
    add_versions("0.1.91", "db587972c25262e9f964893b88f02ce3cc46b904")
    add_versions("0.1.92", "b18f7f7e4d053dcfa2917d7642685e254677db20")
    add_versions("0.1.93", "a555f6128c73d5eb7aee7b5c94617f23b2370f31")
    add_versions("0.1.94", "ae2b29e3784a6200a0416cf27d47828b5aac34d8")
    add_versions("0.1.95", "818bcb847bf69c2b6899a92c18ae690a1bb83dfe")
    add_versions("0.1.96", "f64885a4dc0c18f01dac0417b5bc1af34feb19ed")
    add_versions("0.1.97", "350dd024225564b6f21ea1dfe85bb003d75b0c0d")
    add_versions("0.1.98", "999da28f949448f2e662faf09fd5bb8567dfcaa6")
    add_versions("0.1.99", "53a09b923e6547ee200cf4185544f63b9add6fc8")

    add_includedirs("include", "renderer/include", "decoders/include")
    add_links("rive", "rive_harfbuzz", "rive_sheenbidi", "rive_yoga", "miniaudio", "rive_pls_renderer")

    if is_plat("linux") then
        add_syslinks("dl", "pthread")
    end

    set_policy("package.install_locally", true)
    set_policy("package.install_always", true)

    on_install("linux", "macosx", function (package)
        local sourcedir = package:sourcedir()
        local config = _config_name(package)
        _prepare_premake_script(sourcedir)
        local args = {"build/build_rive.sh", config, "clean" }
        table.join2(args, _build_targets)
        os.vrunv("bash", args, {curdir = sourcedir})
        _install_built_artifacts(package, path.join(sourcedir, "out", config))
    end)

    on_install("windows", function (package)
        local sourcedir = package:sourcedir()
        local config = _config_name(package)
        -- Upstream provides setup_windows_dev.bat and build_rive.bat, not setup_windows_env.bat.
        local args = {"/c", "build\\build_rive.bat", config, "clean" }
        table.join2(args, _build_targets)
        os.vrunv("cmd", args, {curdir = sourcedir})
        _install_built_artifacts(package, path.join(sourcedir, "out", config))
    end)

    on_test(function (package)
        assert(package:has_cxxincludes("rive/artboard.hpp"))
    end)
