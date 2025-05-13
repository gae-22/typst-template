#import "@preview/polylux:0.4.0": *

#let page_ratio = "presentation-16-9" // or presentaion-4-3
#let title_background = "./theme/title_background.png"
#let body_background = "./theme/body_background.png"

// フォントサイズ
#let title_size = 40pt
#let large = 26pt
#let medium = 24pt
#let normal = 22pt
#let small = 20pt
#let tiny = 18pt
// フォント
#let default_font = "Noto Sans CJK JP"
#let math_font = "New Computer Modern Math"

#let header(title) = place(
    left + top,
    float: true,
    clearance: -2.8em,
    dx: 0em,
    dy: -3.6em,
)[
    #text(size: large, weight: "bold")[#title]
    #v(-.6em)
    #line(length: 100%)
]

#let project(title: "", location: "", affilication: "", name: "", email: "", body) = {
    set page(
        paper: page_ratio,
        background: image(title_background, width: 100%),
        margin: (top: 10mm, left: 15mm, right: 15mm, bottom: 10mm)
    )
    set text(size: normal, font: default_font)

    set list(
        marker: (
            [#text(size: tiny)[$square.filled.big$]],
            [#text(size: tiny)[$diamond.filled$]],
            [#scale(x: 150%, y: 250%)[\u{27A2}]],
            [#text(size: tiny)[$bold(circle.filled.small)$]],
            [✔️],
            [・],
            [・],
            [・],
        ),
    )

    // 見出しのスタイル
    show heading.where(level: 1): set text(size: large, weight: "bold")
    show heading.where(level: 2): set text(size: medium, weight: "bold")
    show heading.where(level: 3): set text(size: normal, weight: "semibold")

    // 表・図のスタイル
    set table(stroke: none, inset: .3em)
    show figure.caption: it => { text(size: small)[#it] }
    show figure.where(kind: table): set figure.caption(position: top)
    show figure.where(kind: image): set figure(supplement: "図")
    show figure.where(kind: table): set figure(supplement: "表")


    // 数式のスタイル
    show math.equation: set text(font: math_font)
    show math.equation.where(block: true): set text(size: medium)
    set math.equation(
        numbering: "1.1",
        number-align: (right + bottom),
        supplement: "式",
    )

    // スライドのスタイル
    slide[
        // タイトルスライド
        #align(center + horizon)[#text(size: title_size)[#title]]
        #align(center + horizon)[#text(size: large)[#location]]
        #align(center + bottom)[
            #text(size: 20pt)[
                #affilication \
                #name \
                #email
            ]
        ]
    ]

    counter(page).update(0)

    set page(
        // スライドのスタイル
        paper: page_ratio,
        background: image(body_background, width: 100%, height: 100%),
        margin: (top: 4.5em, left: 8mm, right: 8mm, bottom: 12mm),
        footer: context [
            #align(right)[
                #set text(16pt)
                #pad(right: -.5em)[
                    #counter(page).display(
                        "1 / 1",
                        both: true,
                    )]
            ]
        ],
    )

    body

    pagebreak()

    slide[
        #header[参考文献]
        #bibliography(
            title: none,
            "../bib.yaml",
            style: "ieee",
            full: true,
        )
    ]
}
