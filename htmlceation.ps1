# si il n'y a pas de ficher parametre.ini creation d'aucun variable sinon creation error
$(if(([System.IO.File]::Exists("$(Get-Location)\parametre.ini"))){
    
    # variable recupere dans le parametre.ini

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
    
    
    # initialisations des variables
    $conteurnouveau = 0
    $index = 0
    $indexId = 0
    
    $folders = @()
    $extensions = @()

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
    
    # si il n'y a pas de ficher index.html ne pas chercher  error
    if([System.IO.File]::Exists("$(Get-Location)\index.html")){

        $htmlgetdate = Get-Content -Path index.html
        
        $find = $htmlgetdate -match "[/][/]\d{2}[/]\d{2}[/]\d{4}"
        $find = $find.replace(' //','')
        $yah = $find -split "`n"
        $find = $yah -split " "
    }
})

# le contenu du css

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

#  le contenu du html

$Body = "


" + $(if(![System.IO.File]::Exists("$(Get-Location)\parametre.ini")){
   "<div class=`"error`">
        <div class=`"center`">
            <h1>You need to have a <b>parametre.ini</b> file with</h1>
            <p>
            [Titre]<br>
            Name=Banque de France<br>
            <br>
            [Dossiers]<br>
            C:\Users\guill\Desktop\Stage BDF\PowerShell\metadonne\Fichers<br>
            C:\Users\guill\Desktop\Stage BDF\Rapport logs\test<br>
            <br>
            [Extensions]<br>
            .txt<br>
            .jpg<br>
            <br>
            [Infos]<br>
            Name=oui<br>
            Date=oui<br>
            Taille=oui<br>
            </p>
        </div>
    </div>"
}else{
    "

<!--
 " + $(foreach($folder in $folders){
        $(foreach($file in Get-ChildItem "$folder" -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse) {
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
        <svg xmlns=`"http://www.w3.org/2000/svg`" height=`"150px`" version=`"1.1`" viewBox=`"-6 0 591 591.1795`" width=`"150px`" class=`"`">
            <g>
                <g id=`"surface1`">
                    <path
                        d=`"M 10.964844 163.253906 C 10.75 164.421875 10.628906 165.605469 10.589844 166.789062 L 10.589844 191.101562 C 10.621094 201.121094 16.84375 210.078125 26.230469 213.597656 L 26.230469 249.371094 C 26.273438 261.347656 35.691406 271.191406 47.652344 271.757812 L 47.652344 478.425781 C 35.691406 478.996094 26.273438 488.839844 26.230469 500.8125 L 26.230469 536.480469 C 16.824219 540.09375 10.605469 549.117188 10.589844 559.1875 L 10.589844 582.96875 C 10.589844 587.402344 14.191406 591 18.625 591 L 560.390625 591 C 564.824219 591 568.421875 587.402344 568.421875 582.96875 L 568.421875 559.1875 C 568.40625 549.113281 562.1875 540.089844 552.785156 536.480469 L 552.785156 500.601562 C 552.742188 488.625 543.320312 478.78125 531.363281 478.214844 L 531.363281 271.757812 C 543.320312 271.191406 552.742188 261.347656 552.785156 249.371094 L 552.785156 213.597656 C 562.167969 210.078125 568.390625 201.121094 568.421875 191.101562 L 568.421875 166.949219 C 568.386719 165.765625 568.261719 164.582031 568.046875 163.414062 C 572.085938 165.203125 576.808594 163.382812 578.597656 159.34375 C 580.386719 155.308594 578.566406 150.585938 574.53125 148.792969 L 293.203125 0.929688 C 290.855469 -0.308594 288.050781 -0.308594 285.703125 0.929688 L 4.378906 148.632812 C 0.453125 150.707031 -1.050781 155.5625 1.015625 159.488281 C 2.90625 163.074219 7.171875 164.691406 10.964844 163.253906 Z M 42.296875 227.519531 L 42.296875 215.148438 L 134.945312 215.148438 L 134.945312 227.414062 Z M 248.589844 271.8125 L 248.589844 478.425781 C 236.628906 478.996094 227.210938 488.839844 227.167969 500.8125 L 227.167969 534.980469 L 150.902344 534.980469 L 150.902344 500.8125 C 150.859375 488.839844 141.441406 478.996094 129.480469 478.425781 L 129.480469 271.757812 C 141.441406 271.191406 150.859375 261.347656 150.902344 249.371094 L 150.902344 215.148438 L 227.058594 215.148438 L 227.058594 249.320312 C 227.078125 261.316406 236.503906 271.183594 248.484375 271.757812 Z M 243.234375 227.519531 L 243.234375 215.148438 L 335.886719 215.148438 L 335.886719 227.414062 Z M 449.53125 271.8125 L 449.53125 478.425781 C 437.570312 478.996094 428.148438 488.839844 428.105469 500.8125 L 428.105469 534.980469 L 351.84375 534.980469 L 351.84375 500.8125 C 351.800781 488.839844 342.378906 478.996094 330.421875 478.425781 L 330.421875 271.757812 C 342.378906 271.191406 351.800781 261.347656 351.84375 249.371094 L 351.84375 215.148438 L 428 215.148438 L 428 249.320312 C 428.015625 261.316406 437.441406 271.183594 449.421875 271.757812 Z M 444.175781 227.519531 L 444.175781 215.148438 L 536.824219 215.148438 L 536.824219 227.414062 Z M 536.824219 522.71875 L 536.824219 534.980469 L 444.066406 534.980469 L 444.066406 522.71875 Z M 335.886719 522.71875 L 335.886719 534.980469 L 243.128906 534.980469 L 243.128906 522.71875 Z M 256.515625 255.851562 L 249.554688 255.851562 C 246.003906 255.851562 243.128906 252.976562 243.128906 249.425781 L 243.128906 243.585938 L 335.777344 243.585938 L 335.777344 249.425781 C 335.777344 252.976562 332.902344 255.851562 329.351562 255.851562 Z M 314.410156 271.917969 L 314.410156 478.320312 L 264.550781 478.320312 L 264.550781 271.917969 C 264.550781 271.917969 314.410156 271.917969 314.410156 271.917969 Z M 256.515625 494.386719 L 329.351562 494.386719 C 332.902344 494.386719 335.777344 497.261719 335.777344 500.8125 L 335.777344 506.652344 L 243.128906 506.652344 L 243.128906 500.8125 C 243.128906 497.261719 246.003906 494.386719 249.554688 494.386719 Z M 134.839844 522.71875 L 134.839844 534.980469 L 42.1875 534.980469 L 42.1875 522.71875 Z M 42.1875 249.585938 L 42.1875 243.585938 L 134.839844 243.585938 L 134.839844 249.425781 C 134.839844 252.976562 131.964844 255.851562 128.410156 255.851562 L 48.453125 255.851562 C 44.945312 255.765625 42.15625 252.878906 42.1875 249.371094 Z M 113.417969 272.078125 L 113.417969 478.320312 L 63.609375 478.320312 L 63.609375 271.917969 Z M 42.1875 500.976562 C 42.1875 497.421875 45.0625 494.546875 48.613281 494.546875 L 128.410156 494.546875 C 131.964844 494.546875 134.839844 497.421875 134.839844 500.976562 L 134.839844 506.8125 L 42.1875 506.8125 Z M 552.355469 559.511719 L 552.355469 575.253906 L 26.550781 575.253906 L 26.550781 559.511719 C 26.550781 554.925781 30.265625 551.207031 34.851562 551.207031 L 544.054688 551.207031 C 548.574219 551.207031 552.269531 554.828125 552.355469 559.347656 C 552.355469 559.347656 552.355469 559.511719 552.355469 559.511719 Z M 536.71875 500.976562 L 536.71875 506.8125 L 444.066406 506.8125 L 444.066406 500.976562 C 444.066406 497.421875 446.941406 494.546875 450.492188 494.546875 L 530.453125 494.546875 C 533.878906 494.632812 536.632812 497.386719 536.71875 500.8125 Z M 465.488281 478.480469 L 465.488281 271.917969 L 515.347656 271.917969 L 515.347656 478.320312 Z M 536.71875 249.585938 C 536.71875 253.136719 533.84375 256.011719 530.292969 256.011719 L 450.546875 256.011719 C 446.996094 256.011719 444.121094 253.136719 444.121094 249.585938 L 444.121094 243.585938 L 536.769531 243.585938 Z M 289.453125 16.996094 L 528.683594 142.742188 L 50.222656 142.742188 Z M 26.550781 166.949219 C 26.550781 162.515625 30.148438 158.917969 34.582031 158.917969 L 544.324219 158.917969 C 548.757812 158.917969 552.355469 162.515625 552.355469 166.949219 L 552.355469 191.265625 C 552.355469 195.699219 548.757812 199.296875 544.324219 199.296875 L 34.582031 199.296875 C 30.148438 199.296875 26.550781 195.699219 26.550781 191.265625 Z M 26.550781 166.949219 `"
                        fill=`"#FFFFFF`"
                    />
                </g>
            </g>
        </svg>
        
    </div>
    <span></span>
    <div class=`"title`">
        <h1>" + $Title + "</h1>
    </div>
</div>
<div class=`"container`">
<h3>Rapport du " + (Get-Date -Format "dd") + " " + ((Get-Culture).DateTimeFormat.GetMonthName(8)) + " " + (Get-Date -Format "yyyy") + "</h3>
    <div class=`"rapport`">
        <ul>
            $(foreach($folder in $folders){
                "<li>" + (Get-ChildItem $folder -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse).Count + "<b> fichiers </b>dans le repertoire <b>" + (Split-Path $folder -Leaf) + "</b></li>"
            })
        </ul>
    </div>
</div>
<div class=`"tableau`">
    <table id=`"table_id`" class=`"display`">
        <thead>
        <tr>
            <th>#</th>
            $(if($Name -like 'oui'){
                "<th>Name</th>"
            }
            if($Taille -like 'oui'){
                "<th>Length</th>"
            }
            "<th>Path</th>"
            if($Date -like 'oui'){
                "<th>CreationTime</th>"
            })
            <th>LastAccessTime</th>
            <th>LastWriteTime</th>
            <th>Any Changes ?</th>
        </tr>
        </thead>
        <tbody>
        $(foreach($folder in $folders){
            $(foreach($file in Get-ChildItem "$folder" -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse) {
                $index++
                "<tr>"
                "<td>" + $index + "</th>"
                if($Name -like 'oui'){
                    "<td id=`""$($index)"`"><a href="`"file:///$file`"" title="`"$(if($Name -like 'oui'){ $file.Name }if($Taille -like 'oui'){" / " + $file.Length }if($Date -like 'oui'){" / " + $file.CreationTime })`"">" + $file.Name + "</a></td>"
                }
                if($Taille -like 'oui'){
                    "<td>" + $file.Length + "</td>"
                }
                "<td>" + $file.Fullname + "</td>"
                if($Date -like 'oui'){
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
    <p>Resultat de la recherche via le script</p>
</div>
<div class=`" bottom`" >
    <h3>Banque de France - 2020</h3>
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
        $(foreach($file in Get-ChildItem "$folder" -Include ($(foreach($extension in $extensions){"*" + $extension})) -recurse){
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

# creation de la page html
ConvertTo-HTML -body $Body -Head $css |  Out-File "index.html"

# ouvre le ficher html dans chrome
Start-Process chrome .\index.html

# <div class=`"refresh`">
#     <a href = `"$(Get-Location)\htmlceation.ps1`">
#         <svg xmlns=`"http://www.w3.org/2000/svg`" height=`"40`" viewBox=`"0 0 24 24`" width=`"40`"><path d=`"M0 0h24v24H0z`" fill=`"none`"/><path d=`"M12 5V1L7 6l5 5V7c3.31 0 6 2.69 6 6s-2.69 6-6 6-6-2.69-6-6H4c0 4.42 3.58 8 8 8s8-3.58 8-8-3.58-8-8-8z`"/></svg>
#     </a>
# </div>