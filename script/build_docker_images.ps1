#!/usr/bin/env pwsh

param (
    [string]$registry = '',
    [string]$prefix = '',
    [string]$tag = '',
    [switch]$push = $false
)

$ErrorActionPreference = 'Stop'

$variations = @(
    'emscripten',
    'android',
    'mingw',
    'clang',
    'gcc',
    'nodejs',
    'doxygen'
)

if ($registry -ne '') {
    $registry = "${registry}/"
}

if ($tag -ne '') {
    $tag = ":${tag}"
}

Push-Location

try {
    $script_path = $MyInvocation.MyCommand.Path
    $script_dir = Split-Path $script_path
    $docker_dir = Resolve-Path "${script_dir}/../docker"
    Set-Location $docker_dir

    $built_tags = @()

    $base_name_tag = "${registry}${prefix}base${tag}"
    Write-Output "building image: ${base_name_tag}"
    docker build . `
        --file 'base.dockerfile' `
        --tag "$base_name_tag"
    if ($LASTEXITCODE -ne 0) {
        throw "Error on building image: ${base_image_tag}"
    }

    $built_tags += "$base_name_tag"

    Set-Location variations

    foreach ($variation in $variations) {
        $variation_name_tag = "${registry}${prefix}${variation}${tag}"
        Write-Output "building image: ${variation_name_tag}"
        docker build . `
            --file "${variation}.dockerfile" `
            --build-arg "base=$base_name_tag" `
            --tag "$variation_name_tag"
        if($LASTEXITCODE -ne 0){
            throw "Error on building image: ${variation_image_tag}"
        }
        $built_tags += "$variation_name_tag"
    }

    if ($push) {
        foreach ($built_tag in $built_tags) {
            Write-Output "pushing image: ${built_tag}"
            docker push "$built_tag"
        }
    }
}
finally {
    Pop-Location
}
