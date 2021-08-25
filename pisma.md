---
title: Seminární práce – OJ204 Písma světa
author: Jan Tojnar, učo 433301
header-includes: |
    \usepackage{keep-footnotes-inside-nested-multicols}
    \usepackage{polyglossia}
    \usepackage[a4paper, total={6in, 8in}]{geometry}
    \setdefaultlanguage{czech}
    \setotherlanguages{hebrew,thai}

    \setmainfont{Gentium Plus}
    \newfontfamily\hebrewfont[Renderer=HarfBuzz,Script=Hebrew, Scale=MatchUppercase, Ligatures=TeX]{David Libre}
    \newfontfamily\thaifont[Renderer=HarfBuzz,Script=Thai]{IBM Plex Sans Thai Looped}

    \RequirePackage{pdfmanagement-testphase}
    \directlua{
    --[[ Preserve links from imported packages ]]
    require("newpax")
    newpax.writenewpax("timeline-aramaic")
    newpax.writenewpax("lineage-thai")
    newpax.writenewpax("timeline-thai")
    }

    \usepackage{newpax}
    \newpaxsetup{usefileattributes=true}

    \usepackage{changepage}

    \usepackage{luacode}
    \usepackage{multicol}
    \begin{luacode}
    require("lualibs.lua")
    function load_json(path)
        local file = io.open(path)
        local jsonstring = file:read("*a")
        return utilities.json.tolua(jsonstring)
    end
    function print_nikud(symbol)
        tex.sprint(symbol.name .. " & \\texthebrew{" .. symbol.symbol .. "}\\\\")
    end
    \end{luacode}


# footnotes are enough
suppress-bibliography: true
---

# Hebrejská abeceda \texthebrew{אָלֶף־בֵּית עִבְרִי}

Vyvinula se z Aramejského písma, které se rozšířilo v Perské říši (dynastie Achaimenovců). Aramejské písmo je následníkem písma Fénického, které se vyvinulo z písma Protosinajského, vzniklého z Egyptských hieroglyfů. Mezi další písma vzniklá z Aramejského písma patří písmo Nabatejců (ze kterého se vyvinulo Arabské písmo), Sogdské písmo (ze kterého pochází mj. Mongolské písmo) a pravděpodobně i písmo Bráhmí (ze kterého pochází velké množství písem jižní a jihovýchodní Asie). Pro zápis hebrejštiny nahradilo paleohebrejské písmo (vzniklé z Fénického písma), které zůstává do současnosti jako písmo Samaritánů. [@wiki_hebrew] [@wiki_aramaic]

![Přibližná časová osa vývoje příbuzných písem](timeline-aramaic.svg)

Používá se k zápisu hebrejštiny a dalších jazyků Židů (jidiš, judeo-arabština…), zejména na území Izraele, ale i jinde po světě, díky početné židovské diaspoře.

Má 22 znaků, u kterých se nerozlišuje velikost písmen; pět z nich má odlišnou formu zápisu na konci slova. Jedná se o souhláskové písmo (abdžad), ale existují způsoby zápisu samohlásek pomocí diakritických znamének. Zapisuje se horizontálně zprava doleva.

`\begin{multicols}{2}`{=latex}

## Abeceda

\begin{center}
\begin{luacode}
local jsondata = load_json('hebrew-consonants.json')
tex.print('\\begin{tabular}{|c|c|c|c|}')
tex.print('\\hline Název & Znak & Finála & Znění \\\\ \\hline')
for key, symbol in pairs(jsondata) do
    tex.print(symbol.name .. " & \\texthebrew{" .. symbol.symbol .. "} & \\texthebrew{" .. (symbol.final or "") .. "} & " .. symbol.sound .. "\\\\")
end
tex.print('\\hline\\end{tabular}')
\end{luacode}
\end{center}

Uváděná výslovnost odpovídá moderní standardní hebrejštině používané v Izraeli. V kulatých závorkách je uvedena výslovnost formy znaku s diakritickým znaménkem dageš (viz dále).

\columnbreak

## Diakritická znaménka

### Šin

Šin vyjadřuje dva různé zvuky v závislosti na umístění tečky – s tečkou nalevo \hebrewfont{שׂ} se čte /s/, zatímco s tečkou napravo \hebrewfont{שׁ} se čte /ʃ/.

### Dageš \texthebrew{דָּגֵשׁ‎}

\hebrewfont{ב‎}, \hebrewfont{ג‎}, \hebrewfont{ד‎}, \hebrewfont{כ‎}, \hebrewfont{פ‎} a \hebrewfont{ת‎} mají druhý tvar s tečkou uvnitř (dageš) s odlišnou výslovností: \newline
\hebrewfont{בּ}, \hebrewfont{גּ‎‎}, \hebrewfont{דּ}, \hebrewfont{כּ} (finála \hebrewfont{ךּ‎}), \hebrewfont{פּ} a \hebrewfont{תּ}.

### Nikud \texthebrew{נִקּוּד‎}

Samohlásky se tradičně nevyznačovaly, ale pro jednoznačnost se začal používat systém diakritických znamének.

\setlength{\columnsep}{-10pt}

`\begin{multicols}{2}`{=latex}

\begin{luacode}
local jsondata = load_json('hebrew-nikud.json')
tex.print('\\begin{tabular}{|c|c|}')
tex.print('\\hline Název & Znak \\\\ \\hline')
for key, symbol in pairs(jsondata) do
    tex.print(symbol.name .. " & \\texthebrew{" .. symbol.symbol .. "} \\\\")
end
tex.print('\\hline\\end{tabular}')
\end{luacode}

\columnbreak

(Kolečka reprezentují znaky, ke kterým se znaménka připojí.)

V moderní hebrejštině je však pro vokalizovaný zápis preferováno naznačit samohlásky pomocí „slabých“ souhlásek: \hebrewfont{א‎}, \hebrewfont{ע‎}, \hebrewfont{י‎} a \hebrewfont{ו‎}. [@wiki_mater]

`\end{multicols}`{=latex}
`\end{multicols}`{=latex}

### Šva \texthebrew{שְׁוָא‎}

Dále existuje znaménko šva (\texthebrew{◌ְ}), které

- samostatně vyjadřuje buď
    + hlásku /e/, nebo
    + že znak, který je jím označen se vyslovuje bez samohlásky
- spolu se znaménky patach, kamec nebo segol vyjadřuje zkrácení samohlásky

V moderní hebrejštině se foném „šva“ (ə) nevyskytuje a pro tento účel se tedy nepoužívá. [@wiki_shva]

\pagebreak

## Příklad textu
\texthebrew{בְּרֵאשִׁית בָּרָא אֱלֹהִים אֵת הַשָּׁמַיִם וְאֵת הָאָרֶץ׃ וְהָאָרֶץ הָיְתָה תֹהוּ וָבֹהוּ וְחֹשֶׁךְ עַל־פְּנֵי תְהוֹם וְרוּחַ אֱלֹהִים מְרַחֶפֶת עַל־פְּנֵי הַמָּיִם׃ וַיֹּאמֶר אֱלֹהִים יְהִי אוֹר וַיְהִי־אוֹר׃ וַיֹּאמֶר אֱלֹהִים יְהִי אוֹר וַיְהִי־אוֹר׃ וַיַּרְא אֱלֹהִים אֶת־הָאוֹר כִּי־טוֹב וַיַּבְדֵּל אֱלֹהִים בֵּין הָאוֹר וּבֵין הַחֹשֶׁךְ׃ וַיִּקְרָא אֱלֹהִים לָאוֹר יוֹם וְלַחֹשֶׁךְ קָרָא לָיְלָה וַיְהִי־עֶרֶב וַיְהִי־בֹקֶר יוֹם אֶחָד׃ פ} [@genesis_he]

\textczech{Na počátku stvořil Bůh nebe a zemi. A země byla houšť a poušť — a tma byla nad propastí, a duch Boží vznášel se nad vodami. I pravil Bůh: budiž světlo! — I bylo světlo. I viděl Bůh světlo, že jest dobré, a oddělil Bůh světlo ode tmy. A nazval Bůh světlo dnem a tmu nazval nocí; a byl večer a bylo ráno, den jeden.} [@genesis_cs]

# Thajské písmo \textthai{อักษรไทย}

Vyvinulo se ze Sukhothajského písma, které vzniklo zjednodušením písma Khmérského pro kursívu [@hartmann_1986], které bylo samotné adaptováno z písma Pallava, založeném na Tamilské variantě písma Bráhmí. Písmo Bráhmí pravděpodobně pochází z Aramejského písma. [@wiki_brahmi]  Dle legendy ho vytvořil v roce 1283 král Ram Khamhaeng veliký. [@wiki_thai] Jedná se o první písemný systém používající značky pro zapisování tónů. [@diller_1996]

Používá se k zápisu thajštiny, jejích dialektů a jazyků některých etnik žijících na území Thajska a okolních států.

![Přibližná časová osa vývoje příbuzných písem](timeline-thai.svg)

\pagebreak
<!-- Otherwise footnote will end on the previous page. -->

![Částečný rodokmen jižní větve písem rodiny Bráhmí [@wiki_brahmic]](lineage-thai.svg)

Zapisuje se horizontálně zleva doprava. Jedná se o tzv. abugidu, kde jednotlivé znaky obvykle reprezentují slabiky, tvořené souhláskou doplněnou o samohlásky ve formě znamének psanými nad, pod, nalevo nebo napravo od souhlásky, případně kombinací těchto možností. Obsahuje 44 symbolů pro souhlásky, 16 pro samohlásky (které lze kombinovat do alespoň 32 různých forem) a čtyři diakritická znaménka pro tóny.

Thaiské písmo nemá odlišná malá a velká písmena. Obvykle se nepoužívají mezery mezi slovy. Mezery se používají k oddělování významných pauz (např. mezi větami).

## Souhlásky

\begin{adjustwidth}{-0.85cm}{-0.85cm}
\begin{luacode}
local jsondata = load_json('thai-consonants.json')
tex.print('\\begin{tabular}{|c|l|l|c|c|c|}')
tex.print('\\hline Znak & Název & Význam & Znění & Fin. zn. & Poznámka \\\\ \\hline')
for key, symbol in pairs(jsondata) do
    tex.print("\\textthai{" .. symbol.symbol .. "} & \\textthai{" .. symbol.name .. "} (" .. symbol.name_rtgs .. ") & " .. symbol.name_cs .. " & " .. symbol.sound .. " & " .. symbol.sound_fin .. " & " .. (symbol.note or "") .. " \\\\")
end
tex.print('\\hline\\end{tabular}')
\end{luacode}
\end{adjustwidth}

Název každé souhlásky obsahuje slovo, ve kterém je použita (dle akrofonického principu), pro rozlišení od ostatních stejně znějících hlásek.

Thajské písmo neobsahuje znaky pro složené souhlásky, které jsou časté u ostatních bráhmických písem (jako Barmské nebo Balijské) – slabiky tvořené skupinou souhlásek se zapisují pomocí souhlásek zapsaných vedle sebe obklopených znaky pro samohlásky.

## Samohlásky

\begin{scriptsize}
\begin{adjustwidth}{-1.95cm}{-1.95cm}
\begin{luacode}
local jsondata = load_json('thai-vowels.json')
tex.print('\\begin{tabular}{|c|l|l|l|}')
tex.print('\\hline Znak & Název & Poznámka & Kombinace \\\\ \\hline')
for key, symbol in pairs(jsondata) do
    tex.print((symbol.no_thai and "" or "\\textthai{") .. symbol.symbol .. (symbol.no_thai and "" or "}") .. " & \\textthai{" .. symbol.name .. "} (" .. symbol.name_rtgs .. ") & " .. (symbol.note or "") .. " & \\textthai{" .. symbol.combinations .. "} \\\\")
end
tex.print('\\hline\\end{tabular}')
\end{luacode}
\end{adjustwidth}
\end{scriptsize}

## Příklad textu

\setlength{\columnsep}{-60pt}
`\begin{multicols}{2}`{=latex}

\textthai{
ประเทศไทยรวมเลือดเนื้อชาติเชื้อไทย \\
เป็นประชารัฐ ไผทของไทยทุกส่วน \\
อยู่ดำรงคงไว้ได้ทั้งมวล \\
ด้วยไทยล้วนหมาย รักสามัคคี \\
ไทยนี้รักสงบ แต่ถึงรบไม่ขลาด \\
เอกราชจะไม่ให้ใครข่มขี่ \\
สละเลือดทุกหยาดเป็นชาติพลี \\
เถลิงประเทศชาติไทยทวี มีชัย ชโย
} [@wiki_thai_anthem]

\textczech{
Naše thajská krev Thajskou zemi pojí, \\
každý kousek země patří nám. \\
Již dlouho je svrchovaná, \\
díky naší přetrvávající jednotě. \\
My, Thajští lidé milujeme mír, ale ve válce se nezalekneme. \\
Nedopustíme ohrožení nezávislosti \\
a budeme bojovat do posledního dechu. \\
Nechť Thajský národ vzkvétá a dlouho trvá vítězství. Hurá!
} [^thai_anthem_cs]
`\end{multicols}`{=latex}

[^thai_anthem_cs]: Přeloženo s pomocí [Google Translate](https://translate.google.com), [Wiktionary](https://en.wiktionary.org/) a [thai-dictionary](http://www.thai-language.com/dict/) z thajského originálu, s konzultací anglických překladů na [Wikipedii](https://en.wikipedia.org/wiki/Thai_National_Anthem), [Wikisource](https://en.wikisource.org/wiki/Thai_National_Anthem) a [Thai Language Hut](https://www.thailanguagehut.com/thai-national-anthem-pleng-chaat-thai/) a [polského překladu](https://pl.wikipedia.org/wiki/Hymn_Tajlandii) na polské Wikipedii.
