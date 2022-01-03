#!/usr/bin/env zsh
# Utilities for Uncloudium

download_crx(){
    # Get Chromium version number
    # version="84.0.4147.135" # This was the Chromium version I was using at the time of writing. It may not be the same for you!
    # Get version number from the Flatpak version of Uncloudium
    uncloudium=(flatpak run com.github.Eloston.UngoogledChromium)
    : ${version::=${${$($uncloudium --version | grep -o '[[:digit:]][^[:space:]]\+')}[1]}}
    if (( $? != 0 )); then
        # Get version number from the version of Uncloudium in your $PATH
        uncloudium="chromium"
        : ${version::=${${$($uncloudium --version | grep -o '[[:digit:]][^[:space:]]\+')}[1]}}
    fi
    # Translate a Chrome Web Store URL into a download URL, and download the extension
    # Example Chrome Web Store URL for Privacy Badger extension: https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp
    webstore_url=${1:?Give me the Chrome Web Store URL for the extension! For example, this is the Chrome Web Store URL for Privacy Badger: https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp}
    # Get extension ID
    # crx_id="pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # ID for Privacy Badger extension
    crx_id=${webstore_url:${webstore_url[(I)/]}}
    crx_url="https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${version}&x=id%3D${crx_id}%26installsource%3Dondemand%26uc"
    curl -L $crx_url -o $crx_id.crx
    # I don't know how to install a crx outside of Uncloudium
}
