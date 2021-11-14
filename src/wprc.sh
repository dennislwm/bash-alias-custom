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
    cancel=true
    echo "wp-upload: Minimizes and uploads image(s) to WordPress"
    echo "Usage: [WP_DEBUG=$WP_DEBUG] wp-upload [WP_PATH]"
    echo "Input:"
    echo "  [WP_PATH]: /path/to (default: /Users/dennislwm/fx-git-pull/01transfiguration.sg/minify)"

    WP_PATH="/Users/dennislwm/fx-git-pull/01transfiguration.sg/minify"
    if [ ! -z "$1" ]; then
        WP_PATH=$1
    fi
    WP_TOTAL=$( ls -lAd "$WP_PATH"/* | wc -l | xargs )
    echo "  WP_PATH=$WP_PATH"
    echo "Upload $WP_TOTAL image(s) to WordPress? "

    confirm=$( inp-confirm )
    if [ "$confirm" = "yes" ]; then
        cancel=false
        for file in "$WP_PATH"/*; do
            wp_name=$( basename "$file" )
            wp_ext="${wp_name##*.}"
            echo "Uploading $wp_name"

            wp_data=$( printf '"@%s"' "$file" )
            wp_token=$( echo -n "$WP_USERNAME:$WP_PASSWORD" | base64 )
            wp_header1="$( printf '"content-disposition: attachment; filename=%s"' "$( basename "$wp_name" )" )"
            wp_header2="$( printf '"authorization: Basic %s"' "$wp_token" )"
            wp_header3="$( printf '"cache-control: no-cache"' )"
            wp_header4="$( printf '"content-type: image/%s"' "$wp_ext" )"
            if [ "$WP_DEBUG" = "true" ]; then
                echo curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "$wp_data" -H "$wp_header1" -H "$wp_header2" -H "$wp_header3" -H "$wp_header4" --location
            else
                eval curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "$wp_data" -H "$wp_header1" -H "$wp_header2" -H "$wp_header3" -H "$wp_header4" --location | jq ".id"
            fi
        done
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}

# References
#   https://wordpress.stackexchange.com/questions/325776/add-media-with-wp-rest-api-v2-ii
#   curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "@/Users/dennislwm/fx-git-pull/01transfiguration.sg/asset/cottupdate/minify/cpanel-zone-editor.png" -H "content-disposition: attachment; filename=cpanel-zone-editor.png" -H "authorization: Basic ZGVubmlzbHdtOmx2Y2cgRUFYTSBib29GIDlNTU4gSEROZiBzU3RO" -H "cache-control: no-cache" -H "content-type: image/png" --location