\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ccg-topic}
%
% Provides a way to check whether this class is being used
\def\UsingCCGTopic{}
%
% For now, this is a one-off that disables the " -> ^(...) feature.
\DeclareOption{quotes}{\def\qu@es{YES}}
\DeclareOption{no_quotes}{\def\noqu@es{}}
\ExecuteOptions{quotes}
%
% Do I want any package options?
% Possibilities:
% 1. \mathbb vs. \mathbf for N, Z, Q, R, ...
% 2. Roman or italic d in f(x) dx
%
% Other options can be handed off to the amsart class (e.g. fontsize)
% TODO: for larger notes, I want to use amsbook instead. How should I efficiently unify
% this with shorter notes, which use amsart?
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
%
\ProcessOptions\relax
%
\LoadClass{amsart}
% This has to be put before cleveref for links to work correctly
\numberwithin{equation}{section}
%
\RequirePackage[utf8]{inputenc}
% Keeping this because, even for minimal notes, makes printing take up considerably less paper
\RequirePackage[margin=0.75in]{geometry}
\RequirePackage[usenames, dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{physics}
\RequirePackage{xparse}
\RequirePackage{xspace}
\RequirePackage{mathrsfs}
\RequirePackage[all]{xy}
\RequirePackage{adforn}
\RequirePackage[backref=page]{hyperref}
\RequirePackage[all]{hypcap}
\RequirePackage[capitalize, noabbrev]{cleveref}
% Some shortcuts that simplify live-TeXing using XY.
%
% Forces all XY entries to be typeset with displaymath, which is much more
% common for me
\everyentry={\displaystyle}
%
% Short exact sequences: write
% \shortexact[f][g]{A}{B}{C}, for:
%
% f g
% 0 -> A -> B -> C -> 0,
\DeclareDocumentCommand{\shortexact}{O{} O{} mmmm}{
\xymatrix{
 0\ar[r] & #3\ar[r]^-{#1} & #4\ar[r]^-{#2} & #5\ar[r] & 0#6
}}
% exactly the same, but for 0 -> A -> B -> C
\DeclareDocumentCommand{\leftexact}{O{} O{} mmmm}{
\xymatrix{
 0\ar[r] & #3\ar[r]^-{#1} & #4\ar[r]^-{#2} & #5 #6
}}
% ... and the same, for A -> B -> C -> 0
\DeclareDocumentCommand{\rightexact}{O{} O{} mmmm}{
\xymatrix{
 {#3}\ar[r]^-{#1} & #4\ar[r]^-{#2} & #5\ar[r] & 0#6
}}
%
% Double right arrow, which I found myself writing a lot (e.g. equalizer, kernel,
% or cokernel diagrams)
% usage:
% X\dblarrow[r][f][g] & Y
% f
% X => Y
% g
% Since LaTeX is parsing a class file, we need to tell it that @ is not part of the
% \ar command, or we get some opaque errors.
\makeatother
\DeclareDocumentCommand{\dblarrow}{O{} O{} O{}}{%
 \ar@<0.4ex>[#1]^-{#2}\ar@<-0.4ex>[#1]_-{#3}%
}
% Note: it would be a useful exercise to figure out how to define this so it can
% be used as \dblarrow[r]^f_g.
%
% Useful for morphisms in overcategories (aka slice categories), such as vector bundles,
% covering spaces, field extensions, schemes over a base... or just commutative triangles
% Usage: \overtriangle[f][\pi_1][\pi_2]{X_1}{X_2}{B}.
% Note: the last argument is punctuation; if you don't want punctuation, pass it as {}
\DeclareDocumentCommand{\overtriangle}{O{} O{} O{} mmmm}{
\xymatrix@C=0.4cm{
 {#4}\ar[rr]^{#1}\ar[dr]_{#2} && {#5}\ar[dl]^{#3}\\ % comment for cpp. Don't delete
 & {#6 #7}
}}
\makeatletter
%
% TODO: do I want these going in the other direction?
% Source: http://tug.org/pipermail/xy-pic/2001-July/000015.html
\newcommand{\pullbackcorner}[1][dr]{\save*!/#1+1.2pc/#1:(1,-1)@^{|-}\restore}
\newcommand{\pushoutcorner}[1][dr]{\save*!/#1-1.2pc/#1:(-1,1)@^{|-}\restore}
%
% TODO more? Especially pullback or pushout squares.
%
% An xymatrix environment wrapped in gathered to ensure its equation number is vertically centered
\newcommand{\gathxy}[2][]{%
\begin{gathered}
\xymatrix#1{#2}
\end{gathered}
}
% forked from Arun Debray <ccg, 2019-04-14>
% the creativity is theirs, the mistakes my own
% Mathematicians have lots of fancy fonts
% \mathbb -- notable sets
% TODO: would be nice to allow people to override \mathbb with \mathbf
\newcommand{\A}{\mathbb A} % affine space
\newcommand{\B}{\mathbb B} % unit ball
\newcommand{\C}{\mathbb C} % complex numbers
\newcommand{\D}{\mathbb D} % unit disc inside \C
\newcommand{\E}{\mathbb E} % expected value, family of operads
\newcommand{\F}{\mathbb F} % finite fields
\newcommand{\G}{\mathbb G} % additive/multiplicative groups
\AtBeginDocument{ % some fonts redefine this (e.g. charter)
 \renewcommand{\H}{\mathbb H} % quaternions, upper half-plane
}
\newcommand{\kk}{\mathbb k} % field
\newcommand{\N}{\mathbb N} % natural numbers
\renewcommand{\P}{\mathbb P} % probability, projective space
\newcommand{\Q}{\mathbb Q} % rational numbers
\newcommand{\R}{\mathbb R} % real numbers
\newcommand{\Sph}{\mathbb S} % sphere spectrum
\newcommand{\T}{\mathbb T} % circle group
\newcommand{\Z}{\mathbb Z} % integers
\newcommand{\RP}{\mathbb{RP}} % real projective space
\newcommand{\CP}{\mathbb{CP}} % complex projective space
% \mathcal -- lots of different things
\newcommand{\cA}{\mathcal A} % Steenrod algebra, etc.
\newcommand{\cG}{\mathcal G} % groupoid
\newcommand{\cH}{\mathcal H} % Hilbert space
\newcommand{\cM}{\mathcal M} % moduli space
% \mathfrak -- Lie algebras, open covers, prime ideals
\newcommand{\p}{\mathfrak p} % prime ideal
\newcommand{\q}{\mathfrak q} % another prime ideal
\newcommand{\m}{\mathfrak m} % maximal ideal
\newcommand{\g}{\mathfrak g} % general Lie algebra
\newcommand{\gl}{\mathfrak{gl}} % general linear Lie algebra
\renewcommand{\sl}{\mathfrak{sl}} % special linear
\renewcommand{\sp}{\mathfrak{sp}} % symplectic
\newcommand{\fo}{\mathfrak o} % orthogonal
\newcommand{\so}{\mathfrak{so}} % special orthogonal
\newcommand{\fu}{\mathfrak u} % unitary
\newcommand{\su}{\mathfrak{su}} % special unitary
\newcommand{\fU}{\mathfrak U} % open covers, à la Bott-Tu
\newcommand{\X}{\mathfrak X} % vector fields, tangential structures
% \mathrm -- usually Lie groups
\newcommand{\GL}{\mathrm{GL}} % general linear
\newcommand{\SL}{\mathrm{SL}} % special linear
\AtBeginDocument{ % redefined by mathdesign
 \renewcommand{\O}{\mathrm O} % orthogonal
}
\newcommand{\SO}{\mathrm{SO}} % special orthogonal
\newcommand{\U}{\mathrm U} % unitary
\newcommand{\SU}{\mathrm{SU}} % special unitary
\newcommand{\Sp}{\mathrm{Sp}} % symplectic
\newcommand{\Spin}{\mathrm{Spin}} % spin
\newcommand{\PGL}{\mathrm{PGL}} % projective general linear
\newcommand{\PSL}{\mathrm{PSL}} % projective special linear
% \mathscr -- usually sheaves
\newcommand{\sF}{\mathscr F} % sheaf
\newcommand{\sG}{\mathscr G} % sheaf
\newcommand{\sH}{\mathscr H} % sheaf
\newcommand{\sI}{\mathscr I} % sheaf of ideals, index category
\newcommand{\sL}{\mathscr L} % line bundle
\newcommand{\sM}{\mathscr M} % quasicoherent sheaf
\newcommand{\sO}{\mathscr O} % ring of functions
% \mathsf -- categories
\newcommand{\cat}{\mathsf}
% The user can redefine \cat to be something else (e.g. mathbf). However, I'd also
% like them to be able to redefine things like Set, Grp, and so forth without having
% to use AtBeginDocument.
% TODO: do I even need this AtBeginDocument here...?
\newcommand{\newcat}[2]{\newcommand{#1}{\cat{#2}}}
\AtBeginDocument{
 \newcat{\fC}{C}
 \newcat{\fD}{D}
 \newcat{\Set}{Set} % sets
 \newcat{\Grp}{Grp} % groups
 \newcat{\Gpd}{Gpd} % groupoids
 \newcat{\Ab}{Ab} % abelian groups
 \newcat{\Ring}{Ring} % rings
 \newcat{\Mod}{Mod} % modules (over a ring)
 \newcat{\Alg}{Alg} % algebras (over a ring)
 \newcat{\Vect}{Vect} % vector spaces (over a field)
 \def\Top{\cat{Top}} % topological space (sometimes already defined, e.g. by kpfonts)
 % TODO what other categories of topological/geometric objects do I need?
 \newcat{\LocRing}{LocRing} % locally ringed spaces
 \newcat{\AffSch}{AffSch} % affine schemes
 \newcat{\Sch}{Sch} % schemes
 \newcat{\sSet}{sSet} % simplicial sets
 \newcat{\Man}{Man} % manifolds
 \newcat{\Fun}{Fun} % functor categories
}
% stylistic choices that I would like to have for the pset class
\renewcommand{\vec}[1]{\boldsymbol{\mathbf{#1}}}
\renewcommand{\phi}{\varphi}
\renewcommand{\epsilon}{\varepsilon}
\renewcommand{\emptyset}{\varnothing}
% Setting up some theorem environments
%
% The "exampx" and similar provisional environments are in use so that I can
% append a marker at the end of examples, remarks, claims, facts, and notes.
% (Of course, it would be good for me to determine how to do this automatically.)
% Source: http://tex.stackexchange.com/a/32394/
%
\newtheorem{thm}[equation]{Theorem}
\newtheorem{lem}[equation]{Lemma}
\newtheorem{coro}[equation]{Corollary}
\newtheorem{prop}[equation]{Proposition}
\theoremstyle{definition}
\newtheorem{todo}[equation]{Exercise}
\newtheorem{exampx}[equation]{Example} % --> ex
\newtheorem{defn}[equation]{Definition}
\newtheorem{claim}[equation]{Claim}
\theoremstyle{remark}
\newtheorem{remx}[equation]{Remark} % --> rem
\newtheorem*{fctx}{Fact} % --> fact
\newtheorem*{notex}{Note} % --> note
%
%
\newcommand{\exampleQED}{\smash\adfhalfleftarrowhead}
\newenvironment{ex}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{\exampleQED}\exampx}
  {\popQED\endexampx}
\newenvironment{rem}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{\exampleQED}\remx}
  {\popQED\endremx}
\newenvironment{fact}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{\exampleQED}\fctx}
  {\popQED\endfctx}
\newenvironment{note}
  {\pushQED{\qed}\renewcommand{\qedsymbol}{\exampleQED}\notex}
  {\popQED\endnotex}
%
% Another possibility: "definition-theorems" as used in universal properties
% I will probably also want starred theorems (propositions, subsections, etc.).
% Crefnames, allowing me to reference multiple theorems at once
% \crefname{thm}{Theorem}{Theorems}
% \crefname{lem}{Lemma}{Lemmas}
% \crefname{cor}{Corollary}{Corollaries}
% \crefname{prop}{Proposition}{Propositions}
% \crefname{ex}{Exercise}{Exercises}
% \crefname{exampx}{Example}{Examples}
% \crefname{defn}{Definition}{Definitions}
% \crefname{claim}{Claim}{Claims}
% \crefname{remx}{Remark}{Remarks}
% \crefname{fctx}{Fact}{Facts}
% \crefname{notex}{Note}{Notes}
% sourced from Arun Debray <coltongrainger, 2019-04-14> %
%
% Unfortunately, this has to be placed before loading the cleveref package, so it's
% in packages.tex.
% \numberwithin{equation}{section}
%
% This could be considered a stylistic choice, but works much better with how I use
% subsections as subject changes in a lecture.
\setcounter{tocdepth}{1}
%
% These can be changed downstream
\makeindex % https://en.wikibooks.org/wiki/LaTeX/Indexing
\newcommand{\term}[1]{\emph{#1}\index{#1}} % e.g. "The \term{trace} is defined to be..."
\newcommand{\latin}{\textit} % e.g. \latin{per se}, \latin{mutatis mutandis}
%
% Often, I find myself making a theorem, definition, etc. that's purely a combination
% of statements, either bulleted or numbered. In that case, using \hfill typesets each
% item uniformly. It would probably be best to make this into a custom enumitem
% environment, especially if I want to refer to specific items (e.g. 12.2.1 inside
% Theorem 12.2).
% Usage: \begin{comp}[eggs]{thm}{enumerate}
% \item
% \end{comp}
% sets up an enumerate environment inside a theorem, and labels it "eggs."
\NewDocumentEnvironment{comp}{omm}{%
 \csname #2\endcsname\hfill
 % check for optional argument
 \IfNoValueF{#1}{
  \label{#1}
 }
 \csname #3\endcsname
}{
 \csname end#3\endcsname
 \csname end#2\endcsname
}
%
% since I find myself using \renewcommand{...}{\operatorname{...}} a lot.
\newcommand{\RenewMathOperator}[2]{\renewcommand{#1}{\operatorname{#2}}}
%
% other shortcuts I use for live-TeXing
\newcommand{\vp}{\varphi}
\newcommand{\e}{\varepsilon}
\newcommand{\inj}{\hookrightarrow}
\newcommand{\surj}{\twoheadrightarrow}
\newcommand{\id}{\mathrm{id}}
\newcommand{\pt}{\mathrm{pt}}
\newcommand{\many}[2][\dotsb]{#2 #1 #2} % optional argument for kind of dots
\newcommand{\TFAE}{The following are equivalent}
\newcommand{\TODO}{\textcolor{red}{TODO}}
%
% use a longer \mapsto in display math
\let\shortmapsto\mapsto
\renewcommand{\mapsto}{\mathchoice{\longmapsto}{\shortmapsto}{\shortmapsto}{\shortmapsto}}
%
% This allows \paren{...} to replace \left(...\right) (and similarly for \bkt). For
% \ang, \set, \abs, and \norm, I find myself using autoexpansion less often.
% This code, along with some other shortcuts, is duplicated in my problem set template;
% perhaps I should have them include a common file?
\providecommand{\paren}[1]{\qty( #1 )}
\providecommand{\ang}[1]{\left\langle #1 \right\rangle}
\renewcommand{\abs}[1]{\qty| #1 |} % redefinition from physics.sty
% \norm (defined in physics package)
\providecommand{\bkt}[1]{\qty[ #1 ]}
\providecommand{\set}[1]{\qty{ #1 }}
%
% Now, for a bunch of field-specific commands.
% TODO: document
% TODO: starred command, perhaps as http://tex.stackexchange.com/a/4388/
\newcommand{\newoperator}[1]{\expandafter\DeclareMathOperator\csname #1\endcsname{\operatorname{#1}}}
%
% Algebra
\newoperator{Ann}
\newoperator{Aut}
\newoperator{Cliff}
\newoperator{chr}
\newoperator{coker}
% det (defined in amsmath)
\newoperator{End}
\newoperator{Ext}
\AtBeginDocument{ % some packages redefine this
 \RenewMathOperator{\ev}{ev}
}
\newoperator{Frac}
\newoperator{Gal}
\newoperator{Hom}
% ker (defined in amsmath)
\AtBeginDocument{ % some packages redefine this
 \RenewMathOperator{\Im}{Im} % also complex analysis
}
\newoperator{Mat}
\renewcommand{\op}{^{\cat{op}}} % for the opposite of a category
\newcommand{\rop}{^{\mathrm{op}}} % for the opposite of an algebra or monoid
\AtBeginDocument{
 \RenewMathOperator{\rank}{rank}
}
\newoperator{sign}
% \newoperator{span}
\newoperator{Stab}
\newoperator{Syl}
\newoperator{Fix}
\newoperator{Orb}
\newoperator{core}
\newoperator{Norm}
\newoperator{Sym}
\newoperator{Tor}
% \newoperator{tr} (defined in physics)
\newcommand{\bl}{\text{--}}
\newcommand{\nrel}{\triangleleft}
%
% Algebraic Geometry
\newoperator{Proj}
\newoperator{QCoh}
\newoperator{res} % also complex analysis
\newoperator{Spec}
% Algebraic Topology
\newcommand{\Gr}{\mathrm{Gr}} % Grassmannian -- perhaps move to letters.tex
\newcommand{\hdr}{H_{\mathrm{dR}}}
\newcommand{\KO}{\mathit{KO}}
\newcommand{\KU}{\mathit{KU}}
\newcommand{\KR}{\mathit{KR}}
\newcommand{\ko}{\mathit{ko}}
\newcommand{\ku}{\mathit{ku}}
\newcommand{\Sq}{\mathrm{Sq}}
\newcommand{\wH}{\widetilde H}
\DeclareMathOperator*{\colim}{colim} % colimit notation in homotopy theory
\DeclareMathOperator*{\holim}{holim} % homotopy limit
\DeclareMathOperator*{\hocolim}{hocolim} % homotopy colimit
% some Thom spectra
% TODO: maybe a command to define a whole bunch at once
% or a command for Lie groups: define \G, \MG, \MTG
%
% calling \NewThomSpectrum{G} defines \MG -> \mathit{MG}
% calling \NewMTSpectrum{G} defines \MTG -> \mathit{MTG}
\newcommand{\NewThomSpectrum}[1]{\expandafter\newcommand\csname M#1\endcsname{\mathit{M#1}}}
\newcommand{\NewMTSpectrum}[1]{\expandafter\newcommand\csname MT#1\endcsname{\mathit{MT#1}}}
\newcommand{\BothThomSpectra}[1]{\NewThomSpectrum{#1}\NewMTSpectrum{#1}}
\BothThomSpectra{O}
\BothThomSpectra{SO}
\BothThomSpectra{Spin}
\BothThomSpectra{Pin}
\BothThomSpectra{U} % TODO: I haven't tested these
%\newcommand{\MR}{\mathit{MR}}
%
%
% Complex analysis
% note: Re and Im changes are technically style changes, but almost everyone uses this notation
\AtBeginDocument{
 \RenewMathOperator{\Re}{Re}
}
\newcommand{\delbar}{\overline\partial}
%
% Topology
% \dim (defined in amsart)
\newoperator{codim}
\newoperator{crit}
% \newoperator{curl} (defined in physics)
\newoperator{Diff}
\RenewMathOperator{\div}{div}
\newoperator{ind}
\newoperator{supp}
\newoperator{Cl}
\newoperator{Int}
%
% TQFT
\newcommand{\Bord}{\cat{Bord}}
\newcommand{\TQFT}{\cat{TQFT}}
\newcommand{\fr}{^{\mathrm{fr}}}
%
% to be continued (e.g. a good argmin and argmax)
\renewcommand{\indexname}{Index of Terms and Keywords}
\newcommand{\vocab}[1]{\fbox{#1}\index{#1}} % e.g. "The \term{trace} is defined to be..."
\newcommand{\kw}[1]{\fbox{\color{blue}#1}\index{#1}} % e.g. "The \term{trace} is defined to be..."
\newcommand{\ask}[1]{\fbox{\color{blue}#1}} % e.g. "The \term{trace} is defined to be..."
% this style file is borrowed from Arun Debray <ccg, 2019-04-14> %
% the mistakes are my own %
%
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage[dotinlabels]{titletoc}
% after the font has been chosen
\AtBeginDocument{
 \usepackage{microtype}
}
%
% Set colors for hyperref
\hypersetup{
 colorlinks,
 linkcolor={red!50!black},
 citecolor={green!50!black},
 urlcolor={blue!80!black}
}
%
% Custom section titles
% I really want to not depend on titlesec, as it's frustrating to use. However,
% this setup is stable.
\titleformat{\section}[frame]
  {\normalfont}
  {\filright
   \footnotesize
   \enspace \arabic{section}.\enspace}
  {8pt}
  {\Large\bfseries\filcenter}
\titlecontents{section}[1.5em]{}{\contentslabel{2.3em}}{\hspace*{-2.3em}}{\hfill\contentspage}
%
% Ornament to divide different parts of a section without introducing a new subsection
\newcommand{\orbreak}{
\begin{center}
 \adforn{17}\;\(\cdot\)\;\adforn{18}
 \vspace{0.2cm}
\end{center}
}
%
% some other stylistic changes
% \def\qedsymbol{{\small{\ensuremath{\boxtimes}}}}
%
% The user should specify the following information:
% \topic: what's this document? Neither lecture notes nor a problem set.
% \institution: where the course was held, e.g. "UT Austin"
% \coursenum: course dept. and number, e.g. "M364C"
% \coursename: name of the course, e.g. "Galois Knot Theory"
% \semester: when the course happened, e.g. "Fall 2016"
% \author: who took notes, e.g. "Ted Geisel"
% \date: when these notes were last updated, e.g. \today (optional)
% \email: the author's email, e.g. "seuss_on_the_loose@hotmail.com"
% \thanks: an acknowledgement, e.g. "Thanks to Emily Dickinson for fixing a few typos" (optional)
% Using the following commands, the user will be able to simply write
% \institution{UT Austin}
% \coursenum{M364C}
% and so on.
\newcommand*{\institution}[1]{\newcommand{\@institution}{#1}}
\newcommand*{\coursenum}[1]{\newcommand{\@coursenum}{#1}}
\newcommand*{\coursename}[1]{\newcommand{\@coursename}{#1}}
\newcommand*{\semester}[1]{\newcommand{\@semester}{#1}}
\newcommand*{\topic}[1]{\newcommand{\@topic}{#1}}
\renewcommand*{\email}[1]{\newcommand{\@email}{#1}}
\renewcommand{\@thanks}{\@empty}
\renewcommand{\thanks}[1]{\renewcommand{\@thanks}{#1}}
%
\let\@oldauthor\author
\newcommand*{\d@e}{\@empty}
\renewcommand*{\author}[1]{\renewcommand{\@author}{#1}}
\renewcommand*{\date}[1]{\renewcommand{\d@e}{#1}}
%
% These things should be defined after the user sets everything up in the preamble
\AtBeginDocument{
 % Email with a MAILTO: link
 \newcommand{\linkedemail}{\href{mailto:\@email?subject=\@coursenum\%20\@topic}{\texttt{\@email}}}
 %
 % Front Stuff: standard blurb at the beginning of a document, ToC, etc.
 % Once everything is set up, the user only needs to call \frontstuff.
 %
 % Format title based on amsart's own title command
    \title{\@coursenum{}: \MakeUppercase{\@topic}}
 \@oldauthor{\@author\\\d@e}
 %
 \newcommand{\@blurb}{
  {\small This was prepared for \@institution’s \@coursenum{} (\@coursename) in \@semester. Please send questions, comments, complaints, and corrections to \linkedemail. Any mistakes are my own. \@thanks}
 }
 %
 \newcommand{\frontstuff}{
  \maketitle
  \@blurb
  \tableofcontents
 }
 %
 % Fancy headers
 % TODO this doesn't work like I want it to, and I don't know how to fix it.
 \renewcommand{\sectionmark}[1]{\markleft\thesection. #1}
 %
 \fancyhf{}
 \fancyhead[RO,LE]{\small\thepage}
 \fancyhead[LO]{\small\itshape\nouppercase{\leftmark}}
 \fancyhead[RE]{\small\itshape \@coursenum{}: \@topic}
 \setlength{\headheight}{11.0pt}
 \pagestyle{fancy}
}
