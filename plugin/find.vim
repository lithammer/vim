vim9script

def Find(arg: string, _: bool): list<string>
  return empty(arg) ? [] : systemlist('fd -tf')->matchfuzzy(arg)
enddef

set findfunc=Find
