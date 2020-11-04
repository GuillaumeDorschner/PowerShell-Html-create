# if there is no parametre.ini file creation of no variable otherwise creation error
$(if(([System.IO.File]::Exists("$(Get-Location)\parametre.ini"))){
    
    # variable retrieved in the .ini parameter

    $ini = @{}
    switch -regex -file 'parametre.ini'
    {
        "^\[(.+)\]$"{
            $section = $matches[1]
            $ini[$section] = @{}}
        "(.+)=(.*)"{
            $name, $value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }

    $Title = $ini.Titre.Name
    $Name = $ini.Infos.Name
    $Date = $ini.Infos.Date
    $Taille = $ini.Infos.Taille
    
    
    # initializations of variables
    $conteurnouveau = 0
    $index = 0
    $indexId = 0
    
    $folders = @()
    $extensions = @()
    $exclusions = @()

    $getinfo = Get-Content -Path parametre.ini
    $getinfo = $getinfo -split "`n"
    
    foreach($test in $getinfo){
        if($test -eq ""){
            $ok = 0
        }
        if($ok -eq 1){
            $folders += $test
        }
        if($test -eq "[Dossiers]"){
            $ok = 1
        }
    }
    
    foreach($test in $getinfo){
        if($test -eq ""){
            $ok = 0
        }
        if($ok -eq 1){
            $extensions += $test
        }
        if($test -eq "[Extensions]"){
            $ok = 1
        }
    }
    
    foreach($test in $getinfo){
        if($test -eq ""){
            $ok = 0
        }
        if($ok -eq 1){
            $exclusions += $test
        }
        if($test -eq "[Exclusions]"){
            $ok = 1
        }
    }
    
    # if there is no index.html file don't look for error
    if([System.IO.File]::Exists("$(Get-Location)\index.html")){

        $htmlgetdate = Get-Content -Path index.html
        
        $find = $htmlgetdate -match "[/][/]\d{2}[/]\d{2}[/]\d{4}"
        $find = $find.replace(' //','')
        $yah = $find -split "`n"
        $find = $yah -split " "
    }
})

# the content of the css

$css = "
<title>$Title</title>
<link rel=`"stylesheet`"  href=`" https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css`"  integrity=`" sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh`"  crossorigin=`" anonymous`">
<link rel=`" stylesheet`"  type=`" text/css`"  href=`" https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css`">
<style>
:root{
    --primaryColour: #2E74B5;
}

*{
    margin: 0;
    padding: 0;
}

body{
    width: 100%;
    height: 100vh;
    overflow: hidden;
}

.top{
    width: 100%;
    height: 200px;
    display: flex;
    border: 5px solid #000000;
    background: var(--primaryColour);
}

.logo{
    display: flex;
    align-items: center;
    justify-content: center;
    width: 20%;
    height: 100%;
    color: #ffffff;
}

.top > span{
    width: 5px;
    background: #000000;
}

.title{
    display: flex;
    align-items: center;
    justify-content: center;
    width: 80%;
    height: 100%;
    font-size: 40px;
    color: #ffffff;
}

.date{
    position: absolute;
    right: 10px;
    top: 10px;
    color: #ffffff;
}

.accordeon{
    position: absolute;
    right: 0;
    top: 200px;
    width: 40px;
    height: 40px;
    overflow: hidden;
}

.error{
    position: absolute;
    width: 100%;
    height: 200%;
    background: red;
    z-index: 1;
}

.center{
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
}

.hidd{
    display: none;
}

.refresh{
    position: absolute;
    left: 10px;
    top: 210px;
}

.search{
    width: 50%;
    margin: auto;
}

.bottom{
    position: absolute;
    display: flex;
    align-items: center;
    justify-content: center;
    bottom: 0;
    width: 100%;
    height: 40px;
    background: var(--primaryColour);
    color: #ffffff;
}
</style>"

# the content of the html

$Body = "


" + $(if(![System.IO.File]::Exists("$(Get-Location)\parametre.ini")){
   "<div class=`"error`">
        <div class=`"center`">
            <h1>You need to have a <b>parametre.ini</b> file with</h1>
            <p>
            [Titre]<br>
            Name=Title<br>
            <br>
            [Dossiers]<br>
            C:\Path<br>
            <br>
            [Extensions]<br>
            .txt<br>
            .jpg<br>
            <br>
            [Infos]<br>
            Name=yes<br>
            Date=yes<br>
            Taille=yes<br>
            <br>
            [Exclusions]<br>
            example.txt<br>
            </p>
        </div>
    </div>"
}else{
    "

<!--
 " + $(foreach($folder in $folders){
        $(foreach($file in Get-ChildItem "$folder" -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse  -exclude $exclusions) {
             "//" + $file.LastWriteTime + " " + $file.Name + "`n"
        })
}) + "
-->

<div class=`"accordeon`">
    <div id=`"croix`">
        <svg xmlns=`"http://www.w3.org/2000/svg`" height=`"40`" viewBox=`"0 0 24 24`" width=`"40`"><path d=`"M0 0h24v24H0z`" fill=`"none`"/><path d=`"M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z`"/></svg>
    </div>
    <div id=`"troisbarres`">
        <svg xmlns=`"http://www.w3.org/2000/svg`" height=`"40`" viewBox=`"0 0 24 24`" width=`"40`"><path d=`"M0 0h24v24H0z`" fill=`"none`"/><path d=`"M2 15.5v2h20v-2H2zm0-5v2h20v-2H2zm0-5v2h20v-2H2z`"/></svg>
    </div>
</div>
<div class=`"date`">" + $(Get-Date -Format "dd/MM/yyyy") + "</div>


<div class=`"top`">
    <div class=`"logo`">
        # put the image there
        <img src="" alt="logo">
    </div>
    <span></span>
    <div class=`"title`">
        <h1>" + $Title + "</h1>
    </div>
</div>
<div class=`"container`">
<h3>Report of the " + (Get-Date -Format "dd") + " " + ((Get-Culture).DateTimeFormat.GetMonthName(8)) + " " + (Get-Date -Format "yyyy") + "</h3>
    <div class=`"rapport`">
        <ul>
            $(foreach($folder in $folders){
                "<li>" + (Get-ChildItem $folder -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse  -exclude $exclusions).Count + "<b> fichiers </b>dans le repertoire <b>" + (Split-Path $folder -Leaf) + "</b></li>"
            })
        </ul>
    </div>
</div>
<div class=`"tableau`">
    <table id=`"table_id`" class=`"display`">
        <thead>
        <tr>
            <th>#</th>
            $(if($Name -like 'yes'){
                "<th>Name</th>"
            }
            if($Taille -like 'yes'){
                "<th>Length</th>"
            }
            "<th>Path</th>"
            if($Date -like 'yes'){
                "<th>CreationTime</th>"
            })
            <th>LastAccessTime</th>
            <th>LastWriteTime</th>
            <th>Any Changes ?</th>
        </tr>
        </thead>
        <tbody>
        $(foreach($folder in $folders){
            $(foreach($file in Get-ChildItem "$folder" -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse  -exclude $exclusions) {
                $index++
                "<tr>"
                "<td>" + $index + "</th>"
                if($Name -like 'yes'){
                    "<td id=`""$($index)"`"><a href="`"file:///$file`"" title="`"$(if($Name -like 'yes'){ $file.Name }if($Taille -like 'yes'){" / " + $file.Length }if($Date -like 'yes'){" / " + $file.CreationTime })`"">" + $file.Name + "</a></td>"
                }
                if($Taille -like 'yes'){
                    "<td>" + $file.Length + "</td>"
                }
                "<td>" + $file.Fullname + "</td>"
                if($Date -like 'yes'){
                    "<td>" + $file.CreationTime + "</td>"
                }
                "<td>" + $file.LastAccessTime + "</td>"
                "<td>" + $file.LastWriteTime + "</td>"
                "<td>" + $(for($counter=0; $counter -lt $yah.Length; $counter++){
                    if($find[$counter*3+2] -eq $file.Name){
                        $conteurnouveau++
                        $woo = $file.LastWriteTime -split " "
                        $datefrancaisdernier = $woo[0][3] + $woo[0][4] + $woo[0][2] + $woo[0][0] + $woo[0][1] + $woo[0][5] + $woo[0][6] + $woo[0][7] + $woo[0][8] + $woo[0][9]
                        $datefrancaishtml = $find[$counter*3][3] + $find[$counter*3][4] + $find[$counter*3][2] + $find[$counter*3][0] + $find[$counter*3][1] + $find[$counter*3][5] + $find[$counter*3][6] + $find[$counter*3][7] + $find[$counter*3][8] + $find[$counter*3][9]
    
                        if($(Get-date $datefrancaishtml) -lt $(Get-Date $datefrancaisdernier)){
                                "~"
                        } else {
                            if((get-date $woo[1]) -eq (get-date $find[$counter*3+1])){
                                "="
                            }else{
                                "~"
                            }
                        }
                    }
                })
                $(if($conteurnouveau -eq 0){
                    "New"
                }) + "</td>"
                "</tr>"
            })
        })
        </tbody>
    </table>
</div>
<br>
<div class=`"search hidd`">
    <p>Result of the search via the script</p>
</div>
<div class=`" bottom`" >
    <h3>Something</h3>
</div>
<script  src=`" https://code.jquery.com/jquery-3.5.1.js`"   integrity=`" sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=`"   crossorigin=`" anonymous`" ></script>
<script type=`" text/javascript`"  charset=`" utf8`"  src=`" https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js`" ></script>
<script>
    `$(document).ready( function () {
        `$(`"#table_id`").DataTable();
    } );
    `$(`".accordeon`").click(() => {
        `$(`"#croix`").toggle();
        `$(`".tableau`").toggle(500);
        `$(`".rapport`").toggle(500);
        `$(`".search`").toggle(500);
        `$( `"#theImg`" ).remove();
    })
    " + $(foreach($folder in $folders){
        $(foreach($file in Get-ChildItem "$folder" -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse  -exclude $exclusions){
            $indexId++
            $extn = [IO.Path]::GetExtension($file)
            "`$(`"#" + $indexId + "`").click( ()=> {
                `$(`"#croix`").toggle();
                `$(`".tableau`").toggle(500);
                `$(`".rapport`").toggle(500);
                `$(`".search`").toggle(500);"
                # if text
                if ($extn -eq ".txt") {
                    $textfile = Get-Content $file
                    "`$(`".search`").prepend('<p id=`"theImg`">" + $textfile + "</p>')})`n"  
                }
                # if image
                elseif ($extn -eq ".jpg" -Or $extn -eq ".png") {  
                    $pattern = '[\\]'
                    $nameimage = $file.Fullname
                    $nameimage = $nameimage -replace $pattern, '/'
                    "`$(`".search`").prepend('<img id=`"theImg`" src=`"" + $nameimage + "`" height=`"400px`"/>')})`n"
                }
                # else put error
                else{
                    "`$(`".search`").prepend('<p id=`"theImg`">The file can t be read. You need to have a .txt / .jpg / .png</p>')})`n" 
                }
        })
    }) + "
</script>
"}) + "
"

# creation of the html page
ConvertTo-HTML -body $Body -Head $css |  Out-File "index.html"

# open the html file in chrome
Start-Process chrome .\index.html

# <div class=`"refresh`">
#     <a href = `"$(Get-Location)\htmlceation.ps1`">
#         <svg xmlns=`"http://www.w3.org/2000/svg`" height=`"40`" viewBox=`"0 0 24 24`" width=`"40`"><path d=`"M0 0h24v24H0z`" fill=`"none`"/><path d=`"M12 5V1L7 6l5 5V7c3.31 0 6 2.69 6 6s-2.69 6-6 6-6-2.69-6-6H4c0 4.42 3.58 8 8 8s8-3.58 8-8-3.58-8-8-8z`"/></svg>
#     </a>
# </div>
