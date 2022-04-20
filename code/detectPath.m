function ConnPath = detectPath()
    % detect Connpath on my own computer
    ConnPath = "";

    if getenv("USERNAME") == "Sxing"
        ConnPath = 'C:/Users/Sxing/OneDrive/2021_2/matlab/Connectivity/';
    elseif getenv("USER") == "sxing"
        ConnPath = '/Users/sxing/Developer/matlab/Connectivity';
    else
        throw(MException("detect:error", "Connectivity not found"));
    end

end
