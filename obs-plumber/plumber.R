# plumber.R

#* Show image in OBS
#* @param file The audio filename
#* @get /image
function(filename) {
  # obtain only the base of the file name
  fname <- fs::path_file(filename) |>
    fs::path_ext_remove()

    # define source name based on file name
    source_name <- dplyr::case_when(
      stringr::str_detect(fname, "^animaniacs") ~ "[LOCAL] Animaniacs",
      stringr::str_detect(fname, "^barney") ~ "[LOCAL] Barney",
      stringr::str_detect(fname, "^brockman") ~ "[LOCAL] Brockman",
      stringr::str_detect(fname, "^burns") ~ "[LOCAL] Burns",
      stringr::str_detect(fname, "^earthworm") ~ "[LOCAL] Earthworm Jim",
      stringr::str_detect(fname, "^flanders") ~ "[LOCAL] Flanders",
      stringr::str_detect(fname, "^flynn") ~ "[LOCAL] Flynn",
      stringr::str_detect(fname, "^hank") ~ "[LOCAL] Hank Hill",
      stringr::str_detect(fname, "^homer") ~ "[LOCAL] Homer",
      stringr::str_detect(fname, "^ike") ~ "[LOCAL] Ike",
      stringr::str_detect(fname, "^krusty") ~ "[LOCAL] Krusty",
      stringr::str_detect(fname, "^mcp") ~ "[LOCAL] MCP",
      stringr::str_detect(fname, "^mk2") ~ "[LOCAL] Shao Kahn",
      stringr::str_detect(fname, "^moe") ~ "[LOCAL] Moe",
      stringr::str_detect(fname, "^nelson") ~ "[LOCAL] Nelson",
      stringr::str_detect(fname, "^price") ~ "[LOCAL] Price is Right",
      stringr::str_detect(fname, "^skinner") ~ "[LOCAL] Skinner",
      stringr::str_detect(fname, "^stimpy") ~ "[LOCAL] Stimpy",
      TRUE ~ "")

    # perform calls to OBS websockets
    cli <- crul::HttpClient$new(url = "http://192.168.1.178:4445")

    # unhide image
    res <- cli$post(
      path = "/emit/SetSceneItemProperties",
      body = list(
        `scene-name` = "[ANI] R Code Errors",
        item = source_name,
        visible = TRUE
      ),
      encode = "json"
    )

    # show alert
    res <- cli$post(
      path = "/emit/SetSceneItemProperties",
      body = list(
        `scene-name` = "[B] Animations Scenes",
        item = "[ANI] R Code Errors",
        visible = TRUE
      ),
      encode = "json"
    )

    Sys.sleep(3)

    # hide alert
    res <- cli$post(
      path = "/emit/SetSceneItemProperties",
      body = list(
        `scene-name` = "[B] Animations Scenes",
        item = "[ANI] R Code Errors",
        visible = FALSE
      ),
      encode = "json"
    )

    # hide image
    res <- cli$post(
      path = "/emit/SetSceneItemProperties",
      body = list(
        `scene-name` = "[ANI] R Code Errors",
        item = source_name,
        visible = FALSE
      ),
      encode = "json"
    )
    

    res <- cli$post(
      path = "/emit/SetSceneItemProperties",
      body = list(
        `scene-name` = "[B] Animations Scenes",
        item = "[ANI] R Code Errors",
        visible = FALSE
      ),
      encode = "json"
    )

    list(
      fname = fname,
      source_name = source_name
    )
}
