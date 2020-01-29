%ESTA SESSÃO NÃO DEVE SER ALTERADA PELO PARTICIPANTE, SOB PENA DE REPROVAÇÃO DO TRABALHO.
%=======================================

% ceel.cls
% Template para artigos da CEEL

% Identificação
\ProvidesClass{PETeletrica}[2019/08/13 version 1.0 PET]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[10pt,a4paper,english,brazil]{article}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions

\RequirePackage[utf8]{inputenc}
\RequirePackage[brazilian]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage{graphicx}
\RequirePackage{authblk}
\RequirePackage{titlesec}
\RequirePackage{indentfirst}%paragrafo no inicio de ccada seção
\RequirePackage{caption}%colocar caption no ambiente tabular
\captionsetup{margin=10pt,font=footnotesize}
\RequirePackage{mathptmx} %fonte times new roman (clone)
%criar lista numeradas personalizadas
\RequirePackage{enumerate}
%deixar os links em azul
\RequirePackage{hyperref}
\hypersetup{hidelinks,
breaklinks=true,
colorlinks=false,
urlcolor=blue}

\newcommand*{\evento}[1]{\gdef\@evento{#1}}
\newcommand*{\instituicao}[1]{\gdef\@instituicao{#1}}
\newcommand*{\@instituicao}{Universidade Federal de Uberlândia}
\evento{PET ELÉTRICA}
\date{Notas de Aula}
\instituicao{Universidade Federal de Uberlândia}




% Espaçamento do Título/Seção (Ex: 1. Introdução)
\titlelabel{\hspace{10pt}}

%\bibliographystyle{abntex2-alf}
\renewcommand\refname{\hspace{2mm}Referências}

\def\@maketitle{%
  %\newpage
  %\null
  \vskip 1.5em%
  \begin{center}%
  \let \footnote \thanks
    {\Large \bf \MakeUppercase \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}
      \par}%
    %\vskip 1em%
    %{\large \@date}%
  \end{center}%
 }

\newcommand*{\inserirtitulo}{%
 \vspace*{-1cm}
 \setlength{\fboxsep}{2mm}%already boxed
 \begin{minipage}[t]{0.12\textwidth}
 	\includegraphics[width=1.45\columnwidth]{logo_peteletrica}
 \end{minipage}
 \hfill~
 \begin{minipage}[b]{0.7\textwidth}
   \begin{center}
   {\Large\bf\MakeUppercase{\@evento}\unskip\strut\par}
   {\large\bf\@instituicao\unskip\strut\par}
   {\large\bf\@date\unskip\strut\par}
   \end{center}
 \end{minipage}
 \hfill~
 \begin{minipage}[t]{0.12\textwidth}
 	\begin{flushright}
 	\includegraphics[width=0.8\columnwidth]{ufu.pdf}
    \end{flushright}
 \end{minipage}
 {\let\newpage\relax\maketitle}
}

\RequirePackage{multicol}
\setlength\columnsep{6mm} %espaçamento entre as colunas

%formatar titulos de secoes e subsecoes
\RequirePackage{titlesec}
  \renewcommand{\thesection}{\Roman{section}} 
  \renewcommand{\thesubsection}{\Alph{subsection}}
\titleformat{\section}
  {\centering\normalsize\bfseries}{\thesection .}{0.5em}{\MakeUppercase}
\titleformat{\subsection}
  {\normalsize\itshape\bfseries}{\thesubsection .}{0.5em}{}
  
  

%configurar margens
\RequirePackage[left=1.8cm,right=1.2cm,top=2.5cm,bottom=2.5cm]{geometry}
\setlength{\parindent}{4mm} %tamanho da indentação

\renewcommand\Authands{ e }
\renewcommand\Authand{ e }
