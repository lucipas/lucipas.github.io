import shutil, os, subprocess

"""
TODO:
RSS feed Gen
Social Publish when a path has new files added to it.
"""


# --- Configuration ---
# This is meant to be called in the root directory
# (Root)
#   +--- dist/
#   +--- src/
#   +--- scripts/
SRC_DIR = ".\\src"
DEST_DIR = ".\\dist"
STYLES_DIR = ".\\src\\___\\css\\"
ICON_DIR = ".\\src\\___\\img"
TEMPLATE = ".\\templates\\blog.html"
SED_SCRIPT = ".\\scripts\\macros.sed"
# Probably the most jankiest way to do this b/c I'm lazy.
# TODO Make it where if already there with no diff noop
try:
    shutil.rmtree(DEST_DIR)
except:
    pass
os.mkdir(DEST_DIR)
# ---------------------

for (root, dirs, files) in os.walk(SRC_DIR, topdown=True): # use src to test
    for file in files:
        if(file == ".dir.info"):
            s = os.path.relpath(os.path.join(STYLES_DIR,"index.css"),start=root).replace("src", "dir")
            style = "css:\n\t- "+s.replace("\\","/").replace(" ..","")+"\n"
            try:
                description = "desc: "+open(os.path.join(root, ".about.info"), "r").read()
            except:
                description = ""
            ls_out = str(subprocess.check_output(["ls.exe", root]), encoding="UTF-8").replace(".md",".html").replace(".dir.md","").replace("directory.html", "").split("\n")
            _ = "---\ntitle: Directory of lucipas.dev/"+root.replace("\\","/").replace("./src/","")+"/\n"+description+"\n"+style+"---\n\n"
            for element in ls_out:
                if(element != "" or element !="directory.md"):
                    _r, _ext = os.path.splitext(element)
                    if(_ext == ".html"):
                        _ += "["+_r+"]("+element+")\n"
            __ = open(os.path.join(root, "directory.md"), "w")
            __.write(_)
            __.close()

for (rootDir,dirs,files) in os.walk(SRC_DIR, topdown=True):
    # create the destination path
    dest = rootDir.replace(SRC_DIR, DEST_DIR)
    os.makedirs(dest, exist_ok=True)
    icon = "icon:"+os.path.relpath(os.path.join(ICON_DIR,"icon.png"),start=rootDir).replace("src", "dir").replace("\\","/").replace(" ..","")
    reset = "css:"+os.path.relpath(os.path.join(STYLES_DIR,"index.css"),start=rootDir).replace("src", "dir").replace("\\","/").replace(" ..","")
    for file in files:
        if(file[0] == "."):
            # if file is a dot file noop
            continue
        if(rootDir.find("markdown") >=0):
            continue
        #split the name to root, extension
        root, ext = os.path.splitext(file)
        if(ext == ".md"):
            pandoc = [
                "pandoc",
                "-f", "markdown", # from markdown not markdown_strict apparently b/c we like our yalma metadata.
                "-t", "html", # to hypertext markup language
                os.path.join(rootDir, file), # innie
                "-o", os.path.join(dest, root+".html"), # outtie
                "--template="+TEMPLATE, # using template
                "--wrap=none", # don't wrap
                "-V", icon # using this icon.
                ,"-V", reset # using this css
            ]

            sed = [
                "sed",
                "-E",  # extended regexes
                "-f",  # from script file
                SED_SCRIPT,
                "-i", # edit in place
                os.path.join(rootDir, file) # the file
            ]
            std_out = str(subprocess.check_output(sed, shell=True), encoding="utf-8")
            if(std_out != ""):
                print(std_out)
                std_out = ""

            std_out = str(subprocess.check_output(pandoc, shell=True), encoding="utf-8")
            if(std_out != ""):
                print(std_out)
        else:
            shutil.copy2(os.path.join(rootDir, file), os.path.join(dest, file))

shutil.rmtree(os.path.join(DEST_DIR,"markdown/"))
shutil.rmtree(os.path.join(DEST_DIR,".obsidian/"))