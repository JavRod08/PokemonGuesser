# Global
extends Node

const SAVE_PATH = "user://game_data.json"

var music := true:
	set(value):
		music = value
		if music:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 0)
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80.0)
var sfx := true:
	set(value):
		sfx = value
		if sfx:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), 0)
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), -80.0)

var form_variety := true

var started := false
var mode := "NAMES"
var total_forms := 459
var rng := RandomNumberGenerator.new()

var kanto_best_score := 0
var johto_best_score := 0
var hoenn_best_score := 0
var sinnoh_best_score := 0
var teselia_best_score := 0
var kalos_best_score := 0
var alola_best_score := 0
var galar_best_score := 0
var hisui_best_score := 0
var paldea_best_score := 0
var unknown_best_score := 0
var forms_best_score := 0
var region := ""

const kanto_pokédex = [
	"BULBASAUR",
	"IVYSAUR",
	"VENUSAUR",
	"CHARMANDER",
	"CHARMELEON",
	"CHARIZARD",
	"SQUIRTLE",
	"WARTORTLE",
	"BLASTOISE",
	"CATERPIE",
	"METAPOD",
	"BUTTERFREE",
	"WEEDLE",
	"KAKUNA",
	"BEEDRILL",
	"PIDGEY",
	"PIDGEOTTO",
	"PIDGEOT",
	"RATTATA",
	"RATICATE",
	"SPEAROW",
	"FEAROW",
	"EKANS",
	"ARBOK",
	"PIKACHU",
	"RAICHU",
	"SANDSHREW",
	"SANDSLASH",
	"NIDORAN F",
	"NIDORINA",
	"NIDOQUEEN",
	"NIDORAN M",
	"NIDORINO",
	"NIDOKING",
	"CLEFAIRY",
	"CLEFABLE",
	"VULPIX",
	"NINETALES",
	"JIGGLYPUFF",
	"WIGGLYTUFF",
	"ZUBAT",
	"GOLBAT",
	"ODDISH",
	"GLOOM",
	"VILEPLUME",
	"PARAS",
	"PARASECT",
	"VENONAT",
	"VENOMOTH",
	"DIGLETT",
	"DUGTRIO",
	"MEOWTH",
	"PERSIAN",
	"PSYDUCK",
	"GOLDUCK",
	"MANKEY",
	"PRIMEAPE",
	"GROWLITHE",
	"ARCANINE",
	"POLIWAG",
	"POLIWHIRL",
	"POLIWRATH",
	"ABRA",
	"KADABRA",
	"ALAKAZAM",
	"MACHOP",
	"MACHOKE",
	"MACHAMP",
	"BELLSPROUT",
	"WEEPINBELL",
	"VICTREEBEL",
	"TENTACOOL",
	"TENTACRUEL",
	"GEODUDE",
	"GRAVELER",
	"GOLEM",
	"PONYTA",
	"RAPIDASH",
	"SLOWPOKE",
	"SLOWBRO",
	"MAGNEMITE",
	"MAGNETON",
	"FARFETCH'D",
	"DODUO",
	"DODRIO",
	"SEEL",
	"DEWGONG",
	"GRIMER",
	"MUK",
	"SHELLDER",
	"CLOYSTER",
	"GASTLY",
	"HAUNTER",
	"GENGAR",
	"ONIX",
	"DROWZEE",
	"HYPNO",
	"KRABBY",
	"KINGLER",
	"VOLTORB",
	"ELECTRODE",
	"EXEGGCUTE",
	"EXEGGUTOR",
	"CUBONE",
	"MAROWAK",
	"HITMONLEE",
	"HITMONCHAN",
	"LICKITUNG",
	"KOFFING",
	"WEEZING",
	"RHYHORN",
	"RHYDON",
	"CHANSEY",
	"TANGELA",
	"KANGASKHAN",
	"HORSEA",
	"SEADRA",
	"GOLDEEN",
	"SEAKING",
	"STARYU",
	"STARMIE",
	"MR MIME",
	"SCYTHER",
	"JYNX",
	"ELECTABUZZ",
	"MAGMAR",
	"PINSIR",
	"TAUROS",
	"MAGIKARP",
	"GYARADOS",
	"LAPRAS",
	"DITTO",
	"EEVEE",
	"VAPOREON",
	"JOLTEON",
	"FLAREON",
	"PORYGON",
	"OMANYTE",
	"OMASTAR",
	"KABUTO",
	"KABUTOPS",
	"AERODACTYL",
	"SNORLAX",
	"ARTICUNO",
	"ZAPDOS",
	"MOLTRES",
	"DRATINI",
	"DRAGONAIR",
	"DRAGONITE",
	"MEWTWO",
	"MEW",
]
const johto_pokédex = [
	"CHIKORITA",
	"BAYLEEF",
	"MEGANIUM",
	"CYNDAQUIL",
	"QUILAVA",
	"TYPHLOSION",
	"TOTODILE",
	"CROCONAW",
	"FERALIGATR",
	"SENTRET",
	"FURRET",
	"HOOTHOOT",
	"NOCTOWL",
	"LEDYBA",
	"LEDIAN",
	"SPINARAK",
	"ARIADOS",
	"CROBAT",
	"CHINCHOU",
	"LANTURN",
	"PICHU",
	"CLEFFA",
	"IGGLYBUFF",
	"TOGEPI",
	"TOGETIC",
	"NATU",
	"XATU",
	"MAREEP",
	"FLAAFFY",
	"AMPHAROS",
	"BELLOSSOM",
	"MARILL",
	"AZUMARILL",
	"SUDOWOODO",
	"POLITOED",
	"HOPPIP",
	"SKIPLOOM",
	"JUMPLUFF",
	"AIPOM",
	"SUNKERN",
	"SUNFLORA",
	"YANMA",
	"WOOPER",
	"QUAGSIRE",
	"ESPEON",
	"UMBREON",
	"MURKROW",
	"SLOWKING",
	"MISDREAVUS",
	"UNOWN",
	"WOBBUFFET",
	"GIRAFARIG",
	"PINECO",
	"FORRETRESS",
	"DUNSPARCE",
	"GLIGAR",
	"STEELIX",
	"SNUBBULL",
	"GRANBULL",
	"QWILFISH",
	"SCIZOR",
	"SHUCKLE",
	"HERACROSS",
	"SNEASEL",
	"TEDDIURSA",
	"URSARING",
	"SLUGMA",
	"MAGCARGO",
	"SWINUB",
	"PILOSWINE",
	"CORSOLA",
	"REMORAID",
	"OCTILLERY",
	"DELIBIRD",
	"MANTINE",
	"SKARMORY",
	"HOUNDOUR",
	"HOUNDOOM",
	"KINGDRA",
	"PHANPY",
	"DONPHAN",
	"PORYGON2",
	"STANTLER",
	"SMEARGLE",
	"TYROGUE",
	"HITMONTOP",
	"SMOOCHUM",
	"ELEKID",
	"MAGBY",
	"MILTANK",
	"BLISSEY",
	"RAIKOU",
	"ENTEI",
	"SUICUNE",
	"LARVITAR",
	"PUPITAR",
	"TYRANITAR",
	"LUGIA",
	"HO-OH",
	"CELEBI",
]
const hoenn_pokédex = [
	"TREECKO",
	"GROVYLE",
	"SCEPTILE",
	"TORCHIC",
	"COMBUSKEN",
	"BLAZIKEN",
	"MUDKIP",
	"MARSHTOMP",
	"SWAMPERT",
	"POOCHYENA",
	"MIGHTYENA",
	"ZIGZAGOON",
	"LINOONE",
	"WURMPLE",
	"SILCOON",
	"BEAUTIFLY",
	"CASCOON",
	"DUSTOX",
	"LOTAD",
	"LOMBRE",
	"LUDICOLO",
	"SEEDOT",
	"NUZLEAF",
	"SHIFTRY",
	"TAILLOW",
	"SWELLOW",
	"WINGULL",
	"PELIPPER",
	"RALTS",
	"KIRLIA",
	"GARDEVOIR",
	"SURSKIT",
	"MASQUERAIN",
	"SHROOMISH",
	"BRELOOM",
	"SLAKOTH",
	"VIGOROTH",
	"SLAKING",
	"NINCADA",
	"NINJASK",
	"SHEDINJA",
	"WHISMUR",
	"LOUDRED",
	"EXPLOUD",
	"MAKUHITA",
	"HARIYAMA",
	"AZURILL",
	"NOSEPASS",
	"SKITTY",
	"DELCATTY",
	"SABLEYE",
	"MAWILE",
	"ARON",
	"LAIRON",
	"AGGRON",
	"MEDITITE",
	"MEDICHAM",
	"ELECTRIKE",
	"MANECTRIC",
	"PLUSLE",
	"MINUN",
	"VOLBEAT",
	"ILLUMISE",
	"ROSELIA",
	"GULPIN",
	"SWALOT",
	"CARVANHA",
	"SHARPEDO",
	"WAILMER",
	"WAILORD",
	"NUMEL",
	"CAMERUPT",
	"TORKOAL",
	"SPOINK",
	"GRUMPIG",
	"SPINDA",
	"TRAPINCH",
	"VIBRAVA",
	"FLYGON",
	"CACNEA",
	"CACTURNE",
	"SWABLU",
	"ALTARIA",
	"ZANGOOSE",
	"SEVIPER",
	"LUNATONE",
	"SOLROCK",
	"BARBOACH",
	"WHISCASH",
	"CORPHISH",
	"CRAWDAUNT",
	"BALTOY",
	"CLAYDOL",
	"LILEEP",
	"CRADILY",
	"ANORITH",
	"ARMALDO",
	"FEEBAS",
	"MILOTIC",
	"CASTFORM",
	"KECLEON",
	"SHUPPET",
	"BANETTE",
	"DUSKULL",
	"DUSCLOPS",
	"TROPIUS",
	"CHIMECHO",
	"ABSOL",
	"WYNAUT",
	"SNORUNT",
	"GLALIE",
	"SPHEAL",
	"SEALEO",
	"WALREIN",
	"CLAMPERL",
	"HUNTAIL",
	"GOREBYSS",
	"RELICANTH",
	"LUVDISC",
	"BAGON",
	"SHELGON",
	"SALAMENCE",
	"BELDUM",
	"METANG",
	"METAGROSS",
	"REGIROCK",
	"REGICE",
	"REGISTEEL",
	"LATIAS",
	"LATIOS",
	"KYOGRE",
	"GROUDON",
	"RAYQUAZA",
	"JIRACHI",
	"DEOXYS",
]
const sinnoh_pokédex = [
	"TURTWIG",
	"GROTLE",
	"TORTERRA",
	"CHIMCHAR",
	"MONFERNO",
	"INFERNAPE",
	"PIPLUP",
	"PRINPLUP",
	"EMPOLEON",
	"STARLY",
	"STARAVIA",
	"STARAPTOR",
	"BIDOOF",
	"BIBAREL",
	"KRICKETOT",
	"KRICKETUNE",
	"SHINX",
	"LUXIO",
	"LUXRAY",
	"BUDEW",
	"ROSERADE",
	"CRANIDOS",
	"RAMPARDOS",
	"SHIELDON",
	"BASTIODON",
	"BURMY",
	"WORMADAM",
	"MOTHIM",
	"COMBEE",
	"VESPIQUEN",
	"PACHIRISU",
	"BUIZEL",
	"FLOATZEL",
	"CHERUBI",
	"CHERRIM",
	"SHELLOS",
	"GASTRODON",
	"AMBIPOM",
	"DRIFLOON",
	"DRIFBLIM",
	"BUNEARY",
	"LOPUNNY",
	"MISMAGIUS",
	"HONCHKROW",
	"GLAMEOW",
	"PURUGLY",
	"CHINGLING",
	"STUNKY",
	"SKUNTANK",
	"BRONZOR",
	"BRONZONG",
	"BONSLY",
	"MIME JR",
	"HAPPINY",
	"CHATOT",
	"SPIRITOMB",
	"GIBLE",
	"GABITE",
	"GARCHOMP",
	"MUNCHLAX",
	"RIOLU",
	"LUCARIO",
	"HIPPOPOTAS",
	"HIPPOWDON",
	"SKORUPI",
	"DRAPION",
	"CROAGUNK",
	"TOXICROAK",
	"CARNIVINE",
	"FINNEON",
	"LUMINEON",
	"MANTYKE",
	"SNOVER",
	"ABOMASNOW",
	"WEAVILE",
	"MAGNEZONE",
	"LICKILICKY",
	"RHYPERIOR",
	"TANGROWTH",
	"ELECTIVIRE",
	"MAGMORTAR",
	"TOGEKISS",
	"YANMEGA",
	"LEAFEON",
	"GLACEON",
	"GLISCOR",
	"MAMOSWINE",
	"PORYGON-Z",
	"GALLADE",
	"PROBOPASS",
	"DUSKNOIR",
	"FROSLASS",
	"ROTOM",
	"UXIE",
	"MESPRIT",
	"AZELF",
	"DIALGA",
	"PALKIA",
	"HEATRAN",
	"REGIGIGAS",
	"GIRATINA",
	"CRESSELIA",
	"PHIONE",
	"MANAPHY",
	"DARKRAI",
	"SHAYMIN",
	"ARCEUS",
]
const teselia_pokédex = [
	"VICTINI",
	"SNIVY",
	"SERVINE",
	"SERPERIOR",
	"TEPIG",
	"PIGNITE",
	"EMBOAR",
	"OSHAWOTT",
	"DEWOTT",
	"SAMUROTT",
	"PATRAT",
	"WATCHOG",
	"LILLIPUP",
	"HERDIER",
	"STOUTLAND",
	"PURRLOIN",
	"LIEPARD",
	"PANSAGE",
	"SIMISAGE",
	"PANSEAR",
	"SIMISEAR",
	"PANPOUR",
	"SIMIPOUR",
	"MUNNA",
	"MUSHARNA",
	"PIDOVE",
	"TRANQUILL",
	"UNFEZANT",
	"BLITZLE",
	"ZEBSTRIKA",
	"ROGGENROLA",
	"BOLDORE",
	"GIGALITH",
	"WOOBAT",
	"SWOOBAT",
	"DRILBUR",
	"EXCADRILL",
	"AUDINO",
	"TIMBURR",
	"GURDURR",
	"CONKELDURR",
	"TYMPOLE",
	"PALPIToad",
	"SEISMITOAD",
	"THROH",
	"SAWK",
	"SEWADDLE",
	"SWADLOON",
	"LEAVANNY",
	"VENIPEDE",
	"WHIRLIPEDE",
	"SCOLIPEDE",
	"COTTONEE",
	"WHIMSICOTT",
	"PETILIL",
	"LILLIGANT",
	"BASCULIN",
	"SANDILE",
	"KROKOROK",
	"KROOKODILE",
	"DARUMAKA",
	"DARMANITAN",
	"MARACTUS",
	"DWEBBLE",
	"CRUSTLE",
	"SCRAGGY",
	"SCRAFTY",
	"SIGILYPH",
	"YAMASK",
	"COFAGRIGUS",
	"TIRTOUGA",
	"CARRACOSTA",
	"ARCHEN",
	"ARCHEOPS",
	"TRUBBISH",
	"GARBODOR",
	"ZORUA",
	"ZOROARK",
	"MINCCINO",
	"CINCCINO",
	"GOTHITA",
	"GOTHORITA",
	"GOTHITELLE",
	"SOLOSIS",
	"DUOSION",
	"REUNICLUS",
	"DUCKLETT",
	"SWANNA",
	"VANILLITE",
	"VANILLISH",
	"VANILLUXE",
	"DEERLING",
	"SAWSBUCK",
	"EMOLGA",
	"KARRABLAST",
	"ESCAVALIER",
	"FOONGUS",
	"AMOONGUSS",
	"FRILLISH",
	"JELLICENT",
	"ALOMOMOLA",
	"JOLTIK",
	"GALVANTULA",
	"FERROSEED",
	"FERROTHORN",
	"KLINK",
	"KLANG",
	"KLINKLANG",
	"TYNAMO",
	"EELEKTRIK",
	"EELEKTROSS",
	"ELGYEM",
	"BEHEEYEM",
	"LITWICK",
	"LAMPENT",
	"CHANDELURE",
	"AXEW",
	"FRAXURE",
	"HAXORUS",
	"CUBCHOO",
	"BEARTIC",
	"CRYOGONAL",
	"SHELMET",
	"ACCELGOR",
	"STUNFISK",
	"MIENFOO",
	"MIENSHAO",
	"DRUDDIGON",
	"GOLETT",
	"GOLURK",
	"PAWNIARD",
	"BISHARP",
	"BOUFFALANT",
	"RUFFLET",
	"BRAVIARY",
	"VULLABY",
	"MANDIBUZZ",
	"HEATMOR",
	"DURANT",
	"DEINO",
	"ZWEILOUS",
	"HYDREIGON",
	"LARVESTA",
	"VOLCARONA",
	"COBALION",
	"TERRAKION",
	"VIRIZION",
	"TORNADUS",
	"THUNDURUS",
	"RESHIRAM",
	"ZEKROM",
	"LANDORUS",
	"KYUREM",
	"KELDEO",
	"MELOETTA",
	"GENESECT",
]
const kalos_pokédex = [
	"CHESPIN",
	"QUILLADIN",
	"CHESNAUGHT",
	"FENNEKIN",
	"BRAIXEN",
	"DELPHOX",
	"FROAKIE",
	"FROGADIER",
	"GRENINJA",
	"BUNNELBY",
	"DIGGERSBY",
	"FLETCHLING",
	"FLETCHINDER",
	"TALONFLAME",
	"SCATTERBUG",
	"SPEWPA",
	"VIVILLON",
	"LITLEO",
	"PYROAR",
	"FLABÉBÉ",
	"FLOETTE",
	"FLORGES",
	"SKIDDO",
	"GOGOAT",
	"PANCHAM",
	"PANGORO",
	"FURFROU",
	"ESPURR",
	"MEOWSTIC",
	"HONEDGE",
	"DOUBLADE",
	"AEGISLASH",
	"SPRITZEE",
	"AROMATISSE",
	"SWIRLIX",
	"SLURPUFF",
	"INKAY",
	"MALAMAR",
	"BINACLE",
	"BARBARACLE",
	"SKRELP",
	"DRAGALGE",
	"CLAUNCHER",
	"CLAWITZER",
	"HELIOPTILE",
	"HELIOLISK",
	"TYRUNT",
	"TYRANTRUM",
	"AMAURA",
	"AURORUS",
	"SYLVEON",
	"HAWLUCHA",
	"DEDENNE",
	"CARBINK",
	"GOOMY",
	"SLIGGOO",
	"GOODRA",
	"KLEFKI",
	"PHANTUMP",
	"TREVENANT",
	"PUMPKABOO",
	"GOURGEIST",
	"BERGMITE",
	"AVALUGG",
	"NOIBAT",
	"NOIVERN",
	"XERNEAS",
	"YVELTAL",
	"ZYGARDE",
	"DIANCIE",
	"HOOPA",
	"VOLCANION",
]
const alola_pokédex = [
	"ROWLET",
	"DARTRIX",
	"DECIDUEYE",
	"LITTEN",
	"TORRACAT",
	"INCINEROAR",
	"POPPLIO",
	"BRIONNE",
	"PRIMARINA",
	"PIKIPEK",
	"TRUMBEAK",
	"TOUCANNON",
	"YUNGOOS",
	"GUMSHOOS",
	"GRUBBIN",
	"CHARJABUG",
	"VIKAVOLT",
	"CRABRAWLER",
	"CRABOMINABLE",
	"ORICORIO",
	"CUTIEFLY",
	"RIBOMBEE",
	"ROCKRUFF",
	"LYCANROC",
	"WISHIWASHI",
	"MAREANIE",
	"TOXAPEX",
	"MUDBRAY",
	"MUDSDALE",
	"DEWPIDER",
	"ARAQUANID",
	"FOMANTIS",
	"LURANTIS",
	"MORELULL",
	"SHIINOTIC",
	"SALANDIT",
	"SALAZZLE",
	"STUFFUL",
	"BEWEAR",
	"BOUNSWEET",
	"STEENEE",
	"TSAREENA",
	"COMFEY",
	"ORANGURU",
	"PASSIMIAN",
	"WIMPOD",
	"GOLISOPOD",
	"SANDYGAST",
	"PALOSSAND",
	"PYUKUMUKU",
	"TYPE NULL",
	"SILVALLY",
	"MINIOR",
	"KOMALA",
	"TURTONATOR",
	"TOGEDEMARU",
	"MIMIKYU",
	"BRUXISH",
	"DRAMPA",
	"DHELMISE",
	"JANGMO-O",
	"HAKAMO-O",
	"KOMMO-O",
	"TAPU KOKO",
	"TAPU LELE",
	"TAPU BULU",
	"TAPU FINI",
	"COSMOG",
	"COSMOEM",
	"SOLGALEO",
	"LUNALA",
	"NIHILEGO",
	"BUZZWOLE",
	"PHEROMOSA",
	"XURKITREE",
	"CELESTEELA",
	"KARTANA",
	"GUZZLORD",
	"NECROZMA",
	"MAGEARNA",
	"MARSHADOW",
	"POIPOLE",
	"NAGANADEL",
	"STAKATAKA",
	"BLACEPHALON",
	"ZERAORA",
]
const galar_pokédex = [
	"GROOKEY",
	"THWACKEY",
	"RILLABOOM",
	"SCORBUNNY",
	"RABOOT",
	"CINDERACE",
	"SOBBLE",
	"DRIZZILE",
	"INTELEON",
	"SKWOVET",
	"GREEDENT",
	"ROOKIDEE",
	"CORVISQUIRE",
	"CORVIKNIGHT",
	"BLIPBUG",
	"DOTTLER",
	"ORBEETLE",
	"NICKIT",
	"THIEVUL",
	"GOSSIFLEUR",
	"ELDEGOSS",
	"WOOLOO",
	"DUBWOOL",
	"CHEWTLE",
	"DREDNAW",
	"YAMPER",
	"BOLTUND",
	"ROLYCOLY",
	"CARKOL",
	"COALOSSAL",
	"APPLIN",
	"FLAPPLE",
	"APPLETUN",
	"SILICOBRA",
	"SANDACONDA",
	"CRAMORANT",
	"ARROKUDA",
	"BARRASKEWDA",
	"TOXEL",
	"TOXTRICITY",
	"SIZZLIPEDE",
	"CENTISKORCH",
	"CLOBBOPUS",
	"GRAPPLOCT",
	"SINISTEA",
	"POLTEAGEIST",
	"HATENNA",
	"HATTREM",
	"HATTERENE",
	"IMPIDIMP",
	"MORGREM",
	"GRIMMSNARL",
	"OBSTAGOON",
	"PERRSERKER",
	"CURSOLA",
	"SIRFETCH'D",
	"MR RIME",
	"RUNERIGUS",
	"MILCERY",
	"ALCREMIE",
	"FALINKS",
	"PINCURCHIN",
	"SNOM",
	"FROSMOTH",
	"STONJOURNER",
	"EISCUE",
	"INDEEDEE",
	"MORPEKO",
	"CUFANT",
	"COPPERAJAH",
	"DRACOZOLT",
	"ARCTOZOLT",
	"DRACOVISH",
	"ARCTOVISH",
	"DURALUDON",
	"DREEPY",
	"DRAKLOAK",
	"DRAGAPULT",
	"ZACIAN",
	"ZAMAZENTA",
	"ETERNATUS",
	"KUBFU",
	"URSHIFU",
	"ZARUDE",
	"REGIELEKI",
	"REGIDRAGO",
	"GLASTRIER",
	"SPECTRIER",
	"CALYREX",
]
const hisui_pokédex = [
	"WYRDEER",
	"KLEAVOR",
	"URSALUNA",
	"BASCULEGION",
	"SNEASLER",
	"OVERQWIL",
	"ENAMORUS",
]
const paldea_pokédex = [
	"SPRIGATITO",
	"FLORAGATO",
	"MEOWSCARADA",
	"FUECOCO",
	"CROCALOR",
	"SKELEDIRGE",
	"QUAXLY",
	"QUAXWELL",
	"QUAQUAVAL",
	"LECHONK",
	"OINKOLOGNE",
	"TAROUNTULA",
	"SPIDOPS",
	"NYMBLE",
	"LOKIX",
	"PAWMI",
	"PAWMO",
	"PAWMOT",
	"TANDEMAUS",
	"MAUSHOLD",
	"FIDOUGH",
	"DACHSBUN",
	"SMOLIV",
	"DOLLIV",
	"ARBOLIVA",
	"SQUAWKABILLY",
	"NACLI",
	"NACLSTACK",
	"GARGANACL",
	"CHARCADET",
	"ARMAROUGE",
	"CERULEDGE",
	"TADBULB",
	"BELLIBOLT",
	"WATTREL",
	"KILOWATTREL",
	"MASCHIFF",
	"MABOSSTIFF",
	"SHROODLE",
	"GRAFAIAI",
	"BRAMBLIN",
	"BRAMBLEGHAST",
	"TOEDSCOOL",
	"TOEDSCRUEL",
	"KLAWF",
	"CAPSAKID",
	"SCOVILLAIN",
	"RELLOR",
	"RABSCA",
	"FLITTLE",
	"ESPATHRA",
	"TINKATINK",
	"TINKATUFF",
	"TINKATON",
	"WIGLETT",
	"WUGTRIO",
	"BOMBIRDIER",
	"FINIZEN",
	"PALAFIN",
	"VAROOM",
	"REVAVROOM",
	"CYCLIZAR",
	"ORTHWORM",
	"GLIMMET",
	"GLIMMORA",
	"GREAVARD",
	"HOUNDSTONE",
	"FLAMIGO",
	"CETODDLE",
	"CETITAN",
	"VELUZA",
	"DONDOZO",
	"TATSUGIRI",
	"ANNIHILAPE",
	"CLODSIRE",
	"FARIGIRAF",
	"DUDUNSPARCE",
	"KINGAMBIT",
	"GREAT TUSK",
	"SCREAM TAIL",
	"BRUTE BONNET",
	"FLUTTER MANE",
	"SLITHER WING",
	"SANDY SHOCKS",
	"IRON TREADS",
	"IRON BUNDLE",
	"IRON HANDS",
	"IRON JUGULIS",
	"IRON MOTH",
	"IRON THORNS",
	"FRIGIBAX",
	"ARCTIBAX",
	"BAXCALIBUR",
	"GIMMIGHOUL",
	"GHOLDENGO",
	"WO-CHIEN",
	"CHIEN-PAO",
	"TING-LU",
	"CHI-YU",
	"ROARING MOON",
	"IRON VALIANT",
	"KORAIDON",
	"MIRAIDON",
	"WALKING WAKE",
	"IRON LEAVES",
	"DIPPLIN",
	"POLTCHAGEIST",
	"SINISTCHA",
	"OKIDOGI",
	"MUNKIDORI",
	"FEZANDIPITI",
	"OGERPON",
	"ARCHALUDON",
	"HYDRAPPLE",
	"GOUGING FIRE",
	"RAGING BOLT",
	"IRON BOULDER",
	"IRON CROWN",
	"TERAPAGOS",
	"PECHARUNT",
]
const unknown_pokédex = [
	"MELTAN",
	"MELMETAL",
]

const forms_pokédex = {
	"AEGISLASH": [
		"BLADE FORM",
		"SHIELD FORM"
	],
	"ALCREMIE": [
		"CARAMEL SWIRL BERRY SWEET",
		"CARAMEL SWIRL CLOVER SWEET",
		"CARAMEL SWIRL FLOWER SWEET",
		"CARAMEL SWIRL LOVE SWEET",
		"CARAMEL SWIRL RIBBON SWEET",
		"CARAMEL SWIRL STAR SWEET",
		"CARAMEL SWIRL STRAWBERRY SWEET",
		"LEMON CREAM BERRY SWEET",
		"LEMON CREAM CLOVER SWEET",
		"LEMON CREAM FLOWER SWEET",
		"LEMON CREAM LOVE SWEET",
		"LEMON CREAM RIBBON SWEET",
		"LEMON CREAM STAR SWEET",
		"LEMON CREAM STRAWBERRY SWEET",
		"MATCHA CREAM BERRY SWEET",
		"MATCHA CREAM CLOVER SWEET",
		"MATCHA CREAM FLOWER SWEET",
		"MATCHA CREAM LOVE SWEET",
		"MATCHA CREAM RIBBON SWEET",
		"MATCHA CREAM STAR SWEET",
		"MATCHA CREAM STRAWBERRY SWEET",
		"MINT CREAM BERRY SWEET",
		"MINT CREAM CLOVER SWEET",
		"MINT CREAM FLOWER SWEET",
		"MINT CREAM LOVE SWEET",
		"MINT CREAM RIBBON SWEET",
		"MINT CREAM STAR SWEET",
		"MINT CREAM STRAWBERRY SWEET",
		"RAINBOW SWIRL BERRY SWEET",
		"RAINBOW SWIRL CLOVER SWEET",
		"RAINBOW SWIRL FLOWER SWEET",
		"RAINBOW SWIRL LOVE SWEET",
		"RAINBOW SWIRL RIBBON SWEET",
		"RAINBOW SWIRL STAR SWEET",
		"RAINBOW SWIRL STRAWBERRY SWEET",
		"RUBY CREAM BERRY SWEET",
		"RUBY CREAM CLOVER SWEET",
		"RUBY CREAM FLOWER SWEET",
		"RUBY CREAM LOVE SWEET",
		"RUBY CREAM RIBBON SWEET",
		"RUBY CREAM STAR SWEET",
		"RUBY CREAM STRAWBERRY SWEET",
		"RUBY SWIRL BERRY SWEET",
		"RUBY SWIRL CLOVER SWEET",
		"RUBY SWIRL FLOWER SWEET",
		"RUBY SWIRL LOVE SWEET",
		"RUBY SWIRL RIBBON SWEET",
		"RUBY SWIRL STAR SWEET",
		"RUBY SWIRL STRAWBERRY SWEET",
		"SALTED CREAM BERRY SWEET",
		"SALTED CREAM CLOVER SWEET",
		"SALTED CREAM FLOWER SWEET",
		"SALTED CREAM LOVE SWEET",
		"SALTED CREAM RIBBON SWEET",
		"SALTED CREAM STAR SWEET",
		"SALTED CREAM STRAWBERRY SWEET",
		"VANILLA CREAM BERRY SWEET",
		"VANILLA CREAM CLOVER SWEET",
		"VANILLA CREAM FLOWER SWEET",
		"VANILLA CREAM LOVE SWEET",
		"VANILLA CREAM RIBBON SWEET",
		"VANILLA CREAM STAR SWEET",
		"VANILLA CREAM STRAWBERRY SWEET"
	],
	"ARCANINE": [
		"HISUI",
		"KANTO"
	],
	"ARCEUS": [
		"BUG",
		"DARK",
		"DRAGON",
		"ELECTRIC",
		"FAIRY",
		"FIGHTING",
		"FIRE",
		"FLYING",
		"GHOST",
		"GRASS",
		"GROUND",
		"ICE",
		"NORMAL",
		"POISON",
		"PSYCHIC",
		"ROCK",
		"STEEL",
		"WATER"
	],
	"ARTICUNO": [
		"GALAR",
		"KANTO"
	],
	"AVALUGG": [
		"HISUI",
		"KALOS"
	],
	"BASCULEGION": [
		"FEMALE",
		"MALE"
	],
	"BASCULIN": [
		"BLUE STRIPED",
		"RED STRIPED",
		"WHITE STRIPED"
	],
	"BRAVIARY": [
		"HISUI",
		"UNOVA"
	],
	"BURMY": [
		"PLANT CLOAK",
		"SANDY CLOAK",
		"TRASH CLOAK"
	],
	"CALYREX": [
		"ICE RIDER",
		"SHADOW RIDER",
		"STANDARD"
	],
	"CASTFORM": [
		"NORMAL",
		"RAINY FORM",
		"SNOWY FORM",
		"SUNNY FORM"
	],
	"CHERRIM": [
		"OVERCAST FORM",
		"SUNSHINE FORM"
	],
	"CORSOLA": [
		"GALAR",
		"JOHTO"
	],
	"CRAMORANT": [
		"GORGING FORM",
		"GULPING FORM",
		"STANDARD"
	],
	"DARMANITAN": [
		"GALAR STANDARD",
		"GALAR ZEN MODE",
		"UNOVA STANDARD",
		"UNOVA ZEN MODE"
	],
	"DARUMAKA": [
		"GALAR",
		"UNOVA"
	],
	"DECIDUEYE": [
		"ALOLA",
		"HISUI"
	],
	"DEERLING": [
		"AUTUMN FORM",
		"SPRING FORM",
		"SUMMER FORM",
		"WINTER FORM"
	],
	"DEOXYS": [
		"ATTACK FORM",
		"DEFENSE FORM",
		"NORMAL FORM",
		"SPEED FORM"
	],
	"DIALGA": [
		"ORIGIN FORM",
		"STANDARD"
	],
	"DIGLETT": [
		"ALOLA",
		"KANTO"
	],
	"DUDUNSPARCE": [
		"THREE SEGMENT FORM",
		"TWO SEGMENT FORM"
	],
	"DUGTRIO": [
		"ALOLA",
		"KANTO"
	],
	"EISCUE": [
		"ICE FACE",
		"NOICE FACE"
	],
	"ELECTRODE": [
		"HISUI",
		"KANTO"
	],
	"ENAMORUS": [
		"INCARNATE FORM",
		"THERIAN FORM"
	],
	"ETERNATUS": [
		"ETERNAMAX FORM",
		"STANDARD"
	],
	"EXEGGUTOR": [
		"ALOLA",
		"KANTO"
	],
	"FARFETCH'D": [
		"GALAR",
		"KANTO"
	],
	"FLABÉBÉ": [
		"BLUE FLOWER",
		"ORANGE FLOWER",
		"RED FLOWER",
		"WHITE FLOWER",
		"YELLOW FLOWER"
	],
	"FLOETTE": [
		"BLUE FLOWER",
		"ETERNAL",
		"ORANGE FLOWER",
		"RED FLOWER",
		"WHITE FLOWER",
		"YELLOW FLOWER"
	],
	"FLORGES": [
		"BLUE FLOWER",
		"ORANGE FLOWER",
		"RED FLOWER",
		"WHITE FLOWER",
		"YELLOW FLOWER"
	],
	"FURFROU": [
		"DANDY TRIM",
		"DEBUTANTE TRIM",
		"DIAMOND TRIM",
		"HEART TRIM",
		"KABUKI TRIM",
		"LA REINE TRIM",
		"MATRON TRIM",
		"NATURAL FORM",
		"PHARAOH TRIM",
		"STAR TRIM"
	],
	"GASTRODON": [
		"EAST SEA",
		"WEST SEA"
	],
	"GENESECT": [
		"BURN DRIVE",
		"CHILL DRIVE",
		"DOUSE DRIVE",
		"SHOCK DRIVE",
		"STANDARD"
	],
	"GEODUDE": [
		"ALOLA",
		"KANTO"
	],
	"GIMMIGHOUL": [
		"CHEST FORM",
		"ROAMING FORM"
	],
	"GIRATINA": [
		"ALTERED FORM",
		"ORIGIN FORM"
	],
	"GOLEM": [
		"ALOLA",
		"KANTO"
	],
	"GOODRA": [
		"HISUI",
		"KALOS"
	],
	"GOURGEIST": [
		"AVERAGE SIZE",
		"LARGE SIZE",
		"SMALL SIZE",
		"SUPER SIZE"
	],
	"GRAVELER": [
		"ALOLA",
		"KANTO"
	],
	"GRENINJA": [
		"ASH (BATTLE BOND)",
		"STANDARD"
	],
	"GRIMER": [
		"ALOLA",
		"KANTO"
	],
	"GROUDON": [
		"PRIMAL",
		"STANDARD"
	],
	"GROWLITHE": [
		"HISUI",
		"KANTO"
	],
	"HOOPA": [
		"CONFINED",
		"UNBOUND"
	],
	"INDEEDEE": [
		"FEMALE",
		"MALE"
	],
	"KELDEO": [
		"ORDINARY FORM",
		"RESOLUTE FORM"
	],
	"KYOGRE": [
		"PRIMAL",
		"STANDARD"
	],
	"KYUREM": [
		"BLACK",
		"STANDARD",
		"WHITE"
	],
	"LANDORUS": [
		"INCARNATE FORM",
		"THERIAN FORM"
	],
	"LILLIGANT": [
		"HISUI",
		"UNOVA"
	],
	"LINOONE": [
		"GALAR",
		"HOENN"
	],
	"LYCANROC": [
		"DUSK FORM",
		"MIDDAY FORM",
		"MIDNIGHT FORM"
	],
	"MAGEARNA": [
		"ORIGINAL COLOR",
		"STANDARD"
	],
	"MAROWAK": [
		"ALOLA",
		"KANTO"
	],
	"MAUSHOLD": [
		"FAMILY OF FOUR",
		"FAMILY OF THREE"
	],
	"MELOETTA": [
		"ARIA FORM",
		"PIROUETTE FORM"
	],
	"MEOWSTIC": [
		"FEMALE",
		"MALE"
	],
	"MEOWTH": [
		"ALOLA",
		"GALAR",
		"KANTO"
	],
	"MIMIKYU": [
		"BUSTED FORM",
		"DISGUISED FORM"
	],
	"MINIOR": [
		"BLUE CORE",
		"GREEN CORE",
		"INDIGO CORE",
		"METEOR FORM",
		"ORANGE CORE",
		"RED CORE",
		"VIOLET CORE",
		"YELLOW CORE"
	],
	"MOLTRES": [
		"GALAR",
		"KANTO"
	],
	"MORPEKO": [
		"FULL BELLY MODE",
		"HANGRY MODE"
	],
	"MR MIME": [
		"GALAR",
		"KANTO"
	],
	"MUK": [
		"ALOLA",
		"KANTO"
	],
	"NECROZMA": [
		"DAWN WINGS",
		"DUSK MANE",
		"STANDARD",
		"ULTRA"
	],
	"NINETALES": [
		"ALOLA",
		"KANTO"
	],
	"OGERPON": [
		"CORNERSTONE MASK",
		"HEARTHFLAME MASK",
		"TEAL MASK",
		"WELLSPRING MASK"
	],
	"OINKOLOGNE": [
		"FEMALE",
		"MALE"
	],
	"ORICORIO": [
		"BAILE STYLE",
		"PA'U STYLE",
		"POM-POM STYLE",
		"SENSU STYLE"
	],
	"PALAFIN": [
		"HERO FORM",
		"ZERO FORM"
	],
	"PALKIA": [
		"ORIGIN FORM",
		"STANDARD"
	],
	"PERSIAN": [
		"ALOLA",
		"KANTO"
	],
	"PICHU": [
		"SPIKY-EARED",
		"STANDARD"
	],
	"POLARGEIST": [
		"ANTIQUE FORM",
		"PHONY FORM"
	],
	"PONYTA": [
		"GALAR",
		"KANTO"
	],
	"POULTCHAGEIST": [
		"ARTISAN FORM",
		"COUNTERFEIT FORM"
	],
	"PUMPKABOO": [
		"AVERAGE SIZE",
		"LARGE SIZE",
		"SMALL SIZE",
		"SUPER SIZE"
	],
	"QWILFISH": [
		"HISUI",
		"JOHTO"
	],
	"RAICHU": [
		"ALOLA",
		"KANTO"
	],
	"RAPIDASH": [
		"GALAR",
		"KANTO"
	],
	"RATICATE": [
		"ALOLA",
		"KANTO"
	],
	"RATTATA": [
		"ALOLA",
		"KANTO"
	],
	"ROTOM": [
		"FAN",
		"FROST",
		"HEAT",
		"MOW",
		"STANDARD",
		"WASH"
	],
	"SAMUROTT": [
		"HISUI",
		"UNOVA"
	],
	"SANDSHREW": [
		"ALOLA",
		"KANTO"
	],
	"SANDSLASH": [
		"ALOLA",
		"KANTO"
	],
	"SAWSBUCK": [
		"AUTUMN FORM",
		"SPRING FORM",
		"SUMMER FORM",
		"WINTER FORM"
	],
	"SHAYMIN": [
		"LAND FORM",
		"SKY FORM"
	],
	"SHELLOS": [
		"EAST SEA",
		"WEST SEA"
	],
	"SILVALLY": [
		"TYPE BUG",
		"TYPE DARK",
		"TYPE DRAGON",
		"TYPE ELECTRIC",
		"TYPE FAIRY",
		"TYPE FIGHTING",
		"TYPE FIRE",
		"TYPE FLYING",
		"TYPE GHOST",
		"TYPE GRASS",
		"TYPE GROUND",
		"TYPE ICE",
		"TYPE NORMAL",
		"TYPE POISON",
		"TYPE PSYCHIC",
		"TYPE ROCK",
		"TYPE STEEL",
		"TYPE WATER"
	],
	"SINISTEA": [
		"ANTIQUE FORM",
		"PHONY FORM"
	],
	"SLIGGOO": [
		"HISUI",
		"KALOS"
	],
	"SLOWBRO": [
		"GALAR",
		"KANTO"
	],
	"SLOWKING": [
		"GALAR",
		"JOHTO"
	],
	"SLOWPOKE": [
		"GALAR",
		"KANTO"
	],
	"SNEASEL": [
		"HISUI",
		"JOHTO"
	],
	"SQUAWKABILLY": [
		"BLUE PLUMAGE",
		"GREEN PLUMAGE",
		"WHITE PLUMAGE",
		"YELLOW PLUMAGE"
	],
	"STUNFISK": [
		"GALAR",
		"UNOVA"
	],
	"TATSUGIRI": [
		"CURLY FORM",
		"DROOPY FORM",
		"STRETCHY FORM"
	],
	"TAUROS": [
		"KANTO",
		"PALDEA AQUA BREED",
		"PALDEA BLAZE BREED",
		"PALDEA COMBAT BREED"
	],
	"TERAPAGOS": [
		"NORMAL FORM",
		"STELLAR FORM",
		"TERASTAL FORM"
	],
	"THUNDURUS": [
		"INCARNATE FORM",
		"THERIAN FORM"
	],
	"TORNADUS": [
		"INCARNATE FORM",
		"THERIAN FORM"
	],
	"TOXTRICITY": [
		"AMPED FORM",
		"LOW KEY FORM"
	],
	"TYPHLOSION": [
		"HISUI",
		"JOHTO"
	],
	"UNOWN": [
		"A",
		"B",
		"C",
		"D",
		"E",
		"EXCLAMATION MARK",
		"F",
		"G",
		"H",
		"I",
		"J",
		"K",
		"L",
		"M",
		"N",
		"O",
		"P",
		"Q",
		"QUESTION MARK",
		"R",
		"S",
		"T",
		"U",
		"V",
		"W",
		"X",
		"Y",
		"Z"
	],
	"URSALUNA": [
		"BLOODMOON FORM",
		"STANDARD"
	],
	"URSHIFU": [
		"RAPID STRIKE STYLE",
		"SINGLE STRIKE STYLE"
	],
	"VIVILLON": [
		"ARCHIPELAGO PATTERN",
		"CONTINENTAL PATTERN",
		"ELEGANT PATTERN",
		"FANCY PATTERN",
		"GARDEN PATTERN",
		"HIGH PLAINS PATTERN",
		"ICY SNOW PATTERN",
		"JUNGLE PATTERN",
		"MARINE PATTERN",
		"MEADOW PATTERN",
		"MODERN PATTERN",
		"MONSOON PATTERN",
		"OCEAN PATTERN",
		"POKÉ BALL PATTERN",
		"POLAR PATTERN",
		"RIVER PATTERN",
		"SANDSTORM PATTERN",
		"SAVANNA PATTERN",
		"SUN PATTERN",
		"TUNDRA PATTERN"
	],
	"VOLTORB": [
		"HISUI",
		"KANTO"
	],
	"VULPIX": [
		"ALOLA",
		"KANTO"
	],
	"WEEZING": [
		"GALAR",
		"KANTO"
	],
	"WISHIWASHI": [
		"SCHOOL FORM",
		"SOLO FORM"
	],
	"WOOPER": [
		"JOHTO",
		"PALDEA"
	],
	"WORMADAM": [
		"PLANT CLOAK",
		"SANDY CLOAK",
		"TRASH CLOAK"
	],
	"XERNEAS": [
		"ACTIVE MODE",
		"NEUTRAL MODE"
	],
	"YAMASK": [
		"GALAR",
		"UNOVA"
	],
	"ZACIAN": [
		"CROWNED SWORD",
		"HERO OF MANY BATTLES"
	],
	"ZAMAZENTA": [
		"CROWNED SHIELD",
		"HERO OF MANY BATTLES"
	],
	"ZAPDOS": [
		"GALAR",
		"KANTO"
	],
	"ZIGZAGOON": [
		"GALAR",
		"HOENN"
	],
	"ZOROARK": [
		"HISUI",
		"UNOVA"
	],
	"ZORUA": [
		"HISUI",
		"UNOVA"
	],
	"ZYGARDE": [
		"10%",
		"100% (COMPLETE)",
		"50%"
	]
}

var kanto_learnt_pokémon : Dictionary = {}
var johto_learnt_pokémon : Dictionary = {}
var hoenn_learnt_pokémon : Dictionary = {}
var sinnoh_learnt_pokémon : Dictionary = {}
var teselia_learnt_pokémon : Dictionary = {}
var kalos_learnt_pokémon : Dictionary = {}
var alola_learnt_pokémon : Dictionary = {}
var galar_learnt_pokémon : Dictionary = {}
var hisui_learnt_pokémon : Dictionary = {}
var paldea_learnt_pokémon : Dictionary = {}
var unknown_learnt_pokémon : Dictionary = {}

func _ready() -> void:
	#reset_saved_data()
	load_data()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80.0)
	total_forms = calculate_total_forms(forms_pokédex)
	rng.randomize()

func save_data():
	var save_dict = {
		"kanto_best_score": kanto_best_score,
		"johto_best_score": johto_best_score,
		"hoenn_best_score": hoenn_best_score,
		"sinnoh_best_score": sinnoh_best_score,
		"teselia_best_score": teselia_best_score,
		"kalos_best_score": kalos_best_score,
		"alola_best_score": alola_best_score,
		"galar_best_score": galar_best_score,
		"hisui_best_score": hisui_best_score,
		"paldea_best_score": paldea_best_score,
		"unknown_best_score": unknown_best_score,
		"forms_best_score": forms_best_score,
		"kanto_learnt_pokémon": kanto_learnt_pokémon,
		"johto_learnt_pokémon": johto_learnt_pokémon,
		"hoenn_learnt_pokémon": hoenn_learnt_pokémon,
		"sinnoh_learnt_pokémon": sinnoh_learnt_pokémon,
		"teselia_learnt_pokémon": teselia_learnt_pokémon,
		"kalos_learnt_pokémon": kalos_learnt_pokémon,
		"alola_learnt_pokémon": alola_learnt_pokémon,
		"galar_learnt_pokémon": galar_learnt_pokémon,
		"hisui_learnt_pokémon": hisui_learnt_pokémon,
		"paldea_learnt_pokémon": paldea_learnt_pokémon,
		"unknown_learnt_pokémon": unknown_learnt_pokémon,
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(save_dict, "\t")
		file.store_string(json_string)
		file.close()
	else:
		push_warning("File 'game_data' does not exist or has not been found on path " + SAVE_PATH)

func load_data():
	#if !FileAccess.file_exists(SAVE_PATH):
		#push_warning("File 'game_data' does not exist or has not been found on path " + SAVE_PATH)
		#return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		var parse_result = JSON.parse_string(json_string)
		if parse_result is Dictionary:
			var loaded_data = parse_result
			kanto_best_score = loaded_data.get("kanto_best_score", 0)
			johto_best_score = loaded_data.get("johto_best_score", 0)
			hoenn_best_score = loaded_data.get("hoenn_best_score", 0)
			sinnoh_best_score = loaded_data.get("sinnoh_best_score", 0)
			teselia_best_score = loaded_data.get("teselia_best_score", 0)
			kalos_best_score = loaded_data.get("kalos_best_score", 0)
			alola_best_score = loaded_data.get("alola_best_score", 0)
			galar_best_score = loaded_data.get("galar_best_score", 0)
			hisui_best_score = loaded_data.get("hisui_best_score", 0)
			paldea_best_score = loaded_data.get("paldea_best_score", 0)
			unknown_best_score = loaded_data.get("unknown_best_score", 0)
			forms_best_score = loaded_data.get("forms_best_score", 0)
			kanto_learnt_pokémon = loaded_data.get("kanto_learnt_pokémon", {})
			johto_learnt_pokémon = loaded_data.get("johto_learnt_pokémon", {})
			hoenn_learnt_pokémon = loaded_data.get("hoenn_learnt_pokémon", {})
			sinnoh_learnt_pokémon = loaded_data.get("sinnoh_learnt_pokémon", {})
			teselia_learnt_pokémon = loaded_data.get("teselia_learnt_pokémon", {})
			kalos_learnt_pokémon = loaded_data.get("kalos_learnt_pokémon", {})
			alola_learnt_pokémon = loaded_data.get("alola_learnt_pokémon", {})
			galar_learnt_pokémon = loaded_data.get("galar_learnt_pokémon", {})
			hisui_learnt_pokémon = loaded_data.get("hisui_learnt_pokémon", {})
			paldea_learnt_pokémon = loaded_data.get("paldea_learnt_pokémon", {})
			unknown_learnt_pokémon = loaded_data.get("unknown_learnt_pokémon", {})
		else:
			push_warning("Error al parsear el JSON: " + str(parse_result))
	else:
		push_warning("Error al abrir el archivo para leer: " + str(FileAccess.get_open_error()))

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		await save_data()
		get_tree().quit()

func reset_saved_data():
	kanto_best_score = 0
	johto_best_score = 0
	hoenn_best_score = 0
	sinnoh_best_score = 0
	teselia_best_score = 0
	kalos_best_score = 0
	alola_best_score = 0
	galar_best_score = 0
	hisui_best_score = 0
	paldea_best_score = 0
	unknown_best_score = 0
	forms_best_score = 0
	kanto_learnt_pokémon = {}
	johto_learnt_pokémon = {}
	hoenn_learnt_pokémon = {}
	sinnoh_learnt_pokémon = {}
	teselia_learnt_pokémon = {}
	kalos_learnt_pokémon = {}
	alola_learnt_pokémon = {}
	galar_learnt_pokémon = {}
	hisui_learnt_pokémon = {}
	paldea_learnt_pokémon = {}
	unknown_learnt_pokémon = {}
	save_data()

func calculate_total_forms(dictionary : Dictionary):
	var total_forms := 0
	var all_keys = dictionary.keys()
	for key in all_keys:
		var current_array = dictionary[key]
		total_forms += current_array.size()
	return total_forms
