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
alias wpmn='wp-minimize media minify'
alias wpup='wp-upload minify'

#
# source config files
source $HOME/config/transfiguration.md

wp-minimize() {
    cancel=true
    prompt=true
    if [ "$1" = "-y" ]; then
        prompt=false
        shift
    fi

    if $prompt; then
        echo "wp-minimize: Minimizes image(s)"
        echo "Usage: [WP_DEBUG=$WP_DEBUG] wp-minimize WP_PATH WP_DEST"
        echo "Input:"
        echo "  WP_PATH: /path/to/source"
        echo "  WP_DEST: /path/to/destination"
    fi

    if [ ! -z "$1" ]; then
        WP_PATH=$1
    else
        echo "Error: Missing WP_PATH"
        return
    fi
    if [ ! -z "$2" ]; then
        WP_DEST=$2
    else
        echo "Error: Missing WP_DEST"
        return
    fi
    if [ ! -d "$WP_PATH" ]; then
        echo "Error: $WP_PATH does not exist"
        return
    fi
    if [ ! -d "$WP_DEST" ]; then
        echo "Error: $WP_DEST does not exist"
        return
    fi
    WP_TOTAL=$( ls -lAd "$WP_PATH"/* | wc -l | xargs )
    echo "  WP_PATH=$WP_PATH"
    echo "  WP_DEST=$WP_DEST"
    echo "Minimize $WP_TOTAL image(s)? "

    if $prompt; then
      confirm=$( inp-confirm )
    else
      confirm=yes
    fi
    if [ "$confirm" = "yes" ]; then
        cancel=false
        for file in "$WP_PATH"/*; do
            wp_name=$( basename "$file" )
            wp_ext="${wp_name##*.}"
            echo "Minimizing $wp_name"

            wp_data=$( printf '"@%s"' "$file" )
            wp_token=$( echo -n "$WP_TINYPNG_USERNAME:$WP_TINYPNG_PASSWORD" | base64 )
            wp_header1="$( printf '"authorization: Basic %s"' "$wp_token" )"
            wp_header2="$( printf '"cache-control: no-cache"' )"
            if [ "$WP_DEBUG" = "true" ]; then
                echo curl -X POST --url https://api.tinify.com/shrink --data-binary "$wp_data" -H "$wp_header1" -H "$wp_header2"
            else
                eval curl -X POST --url https://api.tinify.com/shrink --data-binary "$wp_data" -H "$wp_header1" -H "$wp_header2" | jq ".output.url" | xargs curl -o $WP_DEST/"$wp_name"
            fi
        done
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}

wp-upload() {
    cancel=true
    prompt=true
    if [ "$1" = "-y" ]; then
        prompt=false
        shift
    fi

    if $prompt; then
        echo "wp-upload: Minimizes and uploads image(s) to WordPress"
        echo "Usage: [WP_DEBUG=$WP_DEBUG] wp-upload WP_PATH"
        echo "Input:"
        echo "  WP_PATH: /path/to/images"
    fi

    if [ ! -z "$1" ]; then
        WP_PATH=$1
    else
        echo "Error: Missing WP_PATH"
        return
    fi
    if [ ! -d "$WP_PATH" ]; then
        echo "Error: $WP_PATH does not exist"
        return
    fi
    WP_TOTAL=$( ls -lAd "$WP_PATH"/* | wc -l | xargs )
    echo "  WP_PATH=$WP_PATH"
    echo "Upload $WP_TOTAL image(s) to WordPress? "

    if $prompt; then
      confirm=$( inp-confirm )
    else
      confirm="yes"
    fi
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