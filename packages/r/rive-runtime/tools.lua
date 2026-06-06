function ConfigName(package)
    return package:is_debug() and "debug" or "release"
end

