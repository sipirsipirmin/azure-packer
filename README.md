# INIT

```
 make init
```

or 

```
packer init . 
```

# VALIDATE

```
 make build VARS_FILE=<path_to_var_file>
```

or 

```
packer build --vars-file=vars.pkrvars.hcl main.pkr.hcl
```

# BUILD

```
 make build VARS_FILE=<path_to_var_file>
```

or

```
packer build --var-file=vars.pkrvars.hcl .
```

# INIT & BUILD with Docker (not tested)

## INIT
```
docker run \
    -v `pwd`:/workspace -w /workspace \
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
    hashicorp/packer:latest \
    init .
```

## BUILD

```
docker run \
    -v `pwd`:/workspace -w /workspace \
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
    hashicorp/packer:latest \
    build --var-file=vars.pkrvars.hcl .
```
