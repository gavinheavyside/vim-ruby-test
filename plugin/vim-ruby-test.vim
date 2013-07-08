""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test Running
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rspec
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! SetRspec1()
  let t:st_rspec_command="spec"
endfunction

function! SetRspec2()
  let t:st_rspec_command="bundle exec rspec"
endfunction

function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo
  if !exists("t:st_rspec_command")
    call SetRspec2()
  endif
  exec ":!" . t:st_rspec_command . " " . a:filename
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_spec_file = match(expand("%"), '_spec.rb$') != -1
  if in_spec_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>T :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>t :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

command! Rspec1 :call SetRspec1()
command! Rspec2 :call SetRspec2()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cucumber
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! SetCucumberFile()
  " Set the spec file that tests will be run for.
  let t:st_cucumber_file=@%
endfunction

function! RunCucumbers(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo
  exec ":!" . "cucumber" . " " . a:filename . " -f pretty"
endfunction

function! RunCucumberFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_cucumber_file = match(expand("%"), '.feature$') != -1
  if in_cucumber_file
    call SetCucumberFile()
  elseif !exists("t:st_cucumber_file")
    return
  end
  call RunCucumbers(t:st_cucumber_file . command_suffix)
endfunction

function! RunNearestCucumber()
  let feature_line_number = line('.')
  call RunCucumberFile(":" . feature_line_number)
endfunction

" Run this file
map <leader>c :call RunCucumberFile()<cr>
" Run only the example under the cursor
map <leader>C :call RunNearestCucumber()<cr>


