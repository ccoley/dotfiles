" Only set the b:ml_commentstring if it hasn't already been set
if !exists("b:ml_commentstring")
    " Add whitespace to the modeline commentstring
    let b:ml_commentstring = '<!-- %s -->'
end
