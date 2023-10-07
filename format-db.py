import os
import subprocess

luafiles = []
db_directory = os.path.join(os.path.dirname(__file__), 'db')
for root, _, files in os.walk(db_directory):
    for filename in files:
        if filename.endswith('.lua'):
            filepath = os.path.join(root, filename)
            print(os.path.relpath(filepath, db_directory) + '...')

            args = ['lua-format', '--config', 'lua-format.cfg', filepath]
            formatter = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = formatter.communicate()
            assert len(stderr) == 0, filepath

            with open(filepath, 'wb') as fp:
                fp.write(stdout)
