import shutil, os, shlex, subprocess

# --- Configuration ---
SRC_DIR = "./src"
DEST_DIR = "./dist"
TEMPLATE = "./templates/blog.html"
print(TEMPLATE)
# TEMPLATE = r".\\templates\\blog.html"
# ---------------------

for (rootDir,dirs,files) in os.walk(SRC_DIR, topdown=True):
    # create the destination path
    dest = rootDir.replace(SRC_DIR, DEST_DIR)
    os.makedirs(dest, exist_ok=True)


    for file in files:
        if(files[0] == "."):
            # if file is a dot file noop
            continue
        #split the name to root, extension
        root, ext = os.path.splitext(file)
        print(os.path.exists("./templates/blog.html"))
        if(ext == ".md"):
            command = [
                "pandoc",
                "-s", 
                "-f", "markdown_strict",
                "-t", "html",
                os.path.join(rootDir, file),
                "-o", os.path.join(dest, root+".html"),
                "--template",
                TEMPLATE # TEMPLATE is the absolute Path object, converted to string
            ]
            subprocess.Popen(command, shell=True)
        else:
            shutil.copy2(os.path.join(rootDir, file), os.path.join(dest, file))