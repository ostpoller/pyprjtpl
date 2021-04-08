#!/bin/bash

footer_file=footer.html
style_file=style.html

cat << EOF > ${footer_file}
<footer>
<hr />
  <div>
    <span style="float:top-left; ">
      <p class="footer">$(date)</p>
    </span>
    <span style="float:top-right; ">
      <p class="btt"><a href="#top">Back to top of page</a></p>
    </span>
  </div>
</footer>
EOF

cat << EOF > ${style_file}
<!--
Include in pandoc call with option -H style_in_header.html.
It inserts the contents of this file verbatim just in front of the </head> tag.
-->
<style>
body {background-color: rgba(192,192,192, 0.2);
      font-family: verdana;
      color: black;
}

h1 {color: white;
    background-color: #000000;
    padding: 5px;
    padding-left: 10px;
    border-radius: 5px;
}

h1.title {font-size: 200%;
          padding: 30px;
          text-align: center;
}

h2 {color: white;
    background-color: #000000;
    padding: 5px;
    padding-left: 10px;
    border-radius: 5px;
}

h3 {color: white;
    background-color: #404040;
    padding: 5px;
    padding-left: 10px;
    border-radius: 5px;
}

h4 {color: white;
    background-color: #808080;
    padding: 5px;
    padding-left: 10px;
    border-radius: 5px;
}

#p {margin-left: 25px;}

p.subtitle {font-size: 150%;
           text-align: center;
           font-style: italic;
}

p.author {text-align: center;
}

p.date {color: red;
        text-align: center;
}

p.btt {text-align: right;
       font-size: 75%;}

p.footer {text-align: center;
          font-size: 75%;}

#a.sourceLine::before {text-decoration: none;
#                      font-size: 100%;}

pre {margin-left: 40px;
                background: lightgrey;
                padding: 10px;}

code {background: lightgrey;}

pre.sourceCode {margin-left: 40px;
                background: lightgrey;
                padding: 10px;}




div.references {font-size: 100%;}

div.figure {text-align: center;
            font-size: 75%;
            font-weight: bold;
            padding-top: 10px;
}

table {width:75%;
       border-bottom: 2px solid black;
       border-top: 2px solid black;
       margin-left: 25px;
}

th {border-bottom: 1px solid black;
    font-size: 75%;
    vertical-align: bottom;}

td {vertical-align: top;
    font-size: 75%;
    padding-top: 10px;}

tr:hover {background-color: #808080;}

caption { display: table-caption;
          text-align: left;
          font-size: 75%;
          font-weight: bold;
          padding-bottom: 10px;
}


#dl {margin-left: 25px;}
#dt {text-decoration: underline;}

</style>
EOF


pandoc -s --self-contained --toc \
       --highlight-style pygments \
       -H ${style_file} \
       -A ${footer_file} \
       -t html \
       -o build/out.html \
       $*

rm -f ${footer_file}
rm -f ${style_file}