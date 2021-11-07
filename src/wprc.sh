#
# external aliases
alias wp='docker run -it --rm --volumes-from objWp --network container:objWp wordpress:cli'
alias wpconf='wp config'
alias wpd='wp db'
alias wph='wp help'
alias wpi='wp --info'
alias wpp='wp plugin'
alias wppa='wp plugin activate'
alias wppd='wp plugin deactivate'
alias wppi='wp plugin install'
alias wppia='wp plugin install --activate'
alias wppl='wp plugin list'
alias wpps='wp plugin search'
alias wppsa='wp plugin search --format=csv --fields=name,slug,version,requires,tested,rating,ratings,num_ratings,downloaded,active_installs,added,last_updated,short_description,tags,homepage'
alias wppsd='wp plugin search --fields=name,short_description,author,tested,homepage'
alias wppsr='wp plugin search --fields=name,rating,ratings,num_ratings,downloaded,last_updated,active_installs'
alias wppu='wp plugin uninstall'
alias wppud='wp plugin uninstall --deactivate'
alias wpu='wp user'

#
# source config files
source $HOME/config/transfiguration.md

wp-upload() {
    echo "wp-upload: Minimizes and uploads image(s) to WordPress"
    echo "  Usage: wp-upload <wp_fullpath> '<wp_filename>'"
    echo "    wp_fullpath: full path to images"
    echo "    wp_filename: name of file (use `` with wildcards)"
    if [[ ! -z "$1" && ! -z "$2" ]]; then
        echo "  Input:"
        echo "    $1"
        echo "    $2"
        cancel=true
        confirm=$( inp-confirm )
        if [ "$confirm" = "yes" ]; then
            cancel=false
            for file in $1/$2; do
                echo "Uploading $file"
                wp_data=$( printf '"@%s"' "$file" )
                wp_token=$( echo -n "$WP_USERNAME:$WP_PASSWORD" | base64 )
                wp_header1="$( printf '"content-disposition: attachment; filename=%s"' "$( basename "$file" )" )"
                wp_header2="$( printf '"authorization: Basic %s"' "$wp_token" )"
                wp_header3="$( printf '"cache-control: no-cache"' )"
                wp_header4="$( printf '"content-type: image/png"' )"
                echo curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "$wp_data" -H "$wp_header1" -H "$wp_header2" -H "$wp_header3" -H "$wp_header4" --location
                eval curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "$wp_data" -H "$wp_header1" -H "$wp_header2" -H "$wp_header3" -H "$wp_header4" --location
            done
        fi
        if $cancel; then
            echo "user cancel"
        else
            echo "done"
        fi
    fi
}

# References
#   https://wordpress.stackexchange.com/questions/325776/add-media-with-wp-rest-api-v2-ii
#   curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "@/Users/dennislwm/fx-git-pull/01transfiguration.sg/asset/cottupdate/minify/cpanel-zone-editor.png" -H "content-disposition: attachment; filename=cpanel-zone-editor.png" -H "authorization: Basic ZGVubmlzbHdtOmx2Y2cgRUFYTSBib29GIDlNTU4gSEROZiBzU3RO" -H "cache-control: no-cache" -H "content-type: image/png" --location