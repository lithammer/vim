vim9script

g:gitgutter_map_keys = 0

g:gitgutter_sign_allow_clobber = 0
g:gitgutter_sign_priority = 9

# g:gitgutter_sign_added = '▌'
# g:gitgutter_sign_modified = '▌'
# g:gitgutter_sign_removed = '▌'
# g:gitgutter_sign_removed_first_line = '▌'
# g:gitgutter_sign_modified_removed = '▌'
g:gitgutter_sign_added = '│'
g:gitgutter_sign_modified = '│'
g:gitgutter_sign_removed = '│'
g:gitgutter_sign_removed_first_line = '│'
g:gitgutter_sign_modified_removed = '│'

g:gutentags_file_list_command = {
  markers: {
    '.git': 'git ls-files'
  }
}
