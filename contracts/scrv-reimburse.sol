// SPDX-License-Identifier: MIT
// from file output/scrv.json
pragma solidity ^0.6.7;

library ERC20SafeTransfer {
    function safeTransfer(address _tokenAddress, address _to, uint256 _value) internal returns (bool success) {
        // note: both of these could be replaced with manual mstore's to reduce cost if desired
        bytes memory msg = abi.encodeWithSignature("transfer(address,uint256)", _to, _value);
        uint msgSize = msg.length;

        assembly {
            // pre-set scratch space to all bits set
            mstore(0x00, 0xff)

            // note: this requires tangerine whistle compatible EVM
            if iszero(call(gas(), _tokenAddress, 0, add(msg, 0x20), msgSize, 0x00, 0x20)) { revert(0, 0) }
            
            switch mload(0x00)
            case 0xff {
                // token is not fully ERC20 compatible, didn't return anything, assume it was successful
                success := 1
            }
            case 0x01 {
                success := 1
            }
            case 0x00 {
                success := 0
            }
            default {
                // unexpected value, what could this be?
                revert(0, 0)
            }
        }
    }
}

interface ERC20 {
    function transfer(address _to, uint256 _value) external returns (bool success);
}

contract pSCRVReimbursement {
  mapping (address => uint256) public amounts;
  mapping (address => bool) public reimbursed;

  address public constant token = 0x68d14d66B2B0d6E157c06Dc8Fefa3D8ba0e66a89;

  constructor() public {
    amounts[0x324E0b53CefA84CF970833939249880f814557c6] = 110809123814640501242381;
    amounts[0xFE237a0fe73e480582c7F33E10f60832959b5DC3] = 77989510713521236867624;
    amounts[0xc739D8AAFc091735C9996dCB940023EB23528FeD] = 32310521873526628827674;
    amounts[0xFadAFCE89EA2221fa33005640Acf2C923312F2b9] = 1845619398910916113067;
    amounts[0x3b485Db96b4d995862Ba0173E7D90E21CEA1f687] = 29848960431644908160408;
    amounts[0x0154d25120Ed20A516fE43991702e7463c5A6F6e] = 34228495364593951367745;
    amounts[0x2ed7aFA17473e17Ac59908F088b4371D28585476] = 23796818825317413134884;
    amounts[0xd6D30F186E802c1558b8137bd730f7f4AEC17aE7] = 29794331344192995359020;
    amounts[0x40dFc27Ca78B6fbcfb78E91D3D2426Cf6a281E39] = 148784945513572339031;
    amounts[0x80658E3657882cFa73fff0eb20c92Aa5E948230C] = 7916016192111856424798;
    amounts[0x25AfD857C7831C91951Cd94ba63AF237d28604D0] = 24458331652460022014085;
    amounts[0xd653971FA19ef68BC80BECb7720675307Bfb3EE6] = 2036737659768424663358;
    amounts[0x5bC6a64275391dD2D79CF0431DbDD888E5Ef35F1] = 4058695052024111663103;
    amounts[0xaeb7c50878120E6dc8B97e14BA386Cc749812708] = 194178841708744707858;
    amounts[0x69Ed24795649c23F9C13BFE317432fe0e679f1F6] = 53534480814391549880935;
    amounts[0xe479018f5cB6606C6b0AC347Fd27f1B9300A9e7a] = 5056583110936300062728;
    amounts[0x631f82fB2A62496d28780A821f47786b05e2278A] = 1658621997146205780933;
    amounts[0x098003bf2fEa46F9258E193748a1A8E4D0B629c4] = 28124410193516100506459;
    amounts[0x1D096f771713570F529A2db5aac1F296a3613a7e] = 391019573994817346246;
    amounts[0x7b4778d265F5280f600a2917C6Aaf59B44fb2429] = 89746002765085377812833;
    amounts[0x167eC339e5539100BC453AC349F012e194bf85a3] = 112319526848789704791530;
    amounts[0xb90BB05C5bfA9E73F99605bB6c14d8E956a768F3] = 71792814382830242822072;
    amounts[0x61b140B63bB3878dEA83af6C12EE5919f4E4d5dd] = 2607900849765124365202;
    amounts[0xE3E39161d35E9A81edEc667a5387bfAE85752854] = 13713388420403173749918;
    amounts[0x01228D70A0980d85a103d9a753707104757f69bC] = 395152308885911085694;
    amounts[0x5632Cf9a1b4ac936A3c6d3D66EB75c0344c61c2d] = 5173516220081311648859;
    amounts[0xBD1f7d88C76A86C60d41bDDD4819fAe404e7151E] = 2045264789108405581399;
    amounts[0xC2204F33c47F26aC340C5f684889341b517e900C] = 14156682252400972408162;
    amounts[0x505846a0a89dd26fA5cD0677FD5406039c218620] = 277509705363435307421644;
    amounts[0x6c5384bBaE7aF65Ed1b6784213A81DaE18e528b2] = 1296911587014815599291451;
    amounts[0x95A70A517C9E87F0Bd70e380bDE99a41d31D917d] = 478833140704198553664687;
    amounts[0x2e895aE59E5569E48D858E143911e3BEfbC63A12] = 1946638547892886650262;
    amounts[0x8B64673c9a482913a6e2c1298637532947cD96eE] = 29240525910886771409769;
    amounts[0x5C9B2D7fD4ab5b3a672099301E825d6a586343Af] = 19454404399885105217839;
    amounts[0x444e01DCb3A1eC1b1aa1344505ed7C8690D53281] = 796381770888895154727846;
    amounts[0xe1163DCFb598F74da146a83CC878731d553abBfe] = 44682026401028286114287;
    amounts[0x4FC5A19E45De02592a4D0241869f969F68255E9c] = 5058460992875484720427;
    amounts[0xECEDa45AD3c57681c7e49B47072A014dF54Ee659] = 193198718187513787801239;
    amounts[0xDF1AeFb979d180b4d67CCA9Abb4c5108C89dC8A4] = 9187471016391728465226;
    amounts[0xdbeDB1B7d359b0776E139D385c78a5ac9B27C0f9] = 48055106257110958349544;
    amounts[0x70e439584Ef1BA300106b9c16543eaa1DE676Dc2] = 39769552465597373105797;
    amounts[0x3a607Cf105e830c023003056514b86E9De0A691e] = 3598234670685268948011;
    amounts[0xaBe780bDc3872B4DEC16bD44B2bB999f9151aE28] = 2815015080849001541986;
    amounts[0x22414282c64bB1Ef62B9736d3B584f59b5Bb20d3] = 74570664938238776627542;
    amounts[0x2bc2CA2A7B3E6EdEF35223a211aC3B0b9b8d4346] = 6012168606752980239536;
    amounts[0x4EB71d22AF87ECf228a856075c80c143890256e4] = 8278996136260701137031;
    amounts[0x15BDd87fE60E212C150d18D205766bDA86350152] = 35732711773110929893217;
    amounts[0xe765e0c5f5E6AceA5175a7da83B88c5Dc0f2b437] = 14886651728039449837243;
    amounts[0x4EC355d5780c9554EbdF1B40e9734A573D81052C] = 16406445891462325649664;
    amounts[0x5668EAd1eDB8E2a4d724C8fb9cB5fFEabEB422dc] = 42255937715160975076954;
    amounts[0x3e10048efEd71C56bae0c2E8deA106f53fae6422] = 701378171844157880310;
    amounts[0x907D9B32654B8D43e8737E0291Ad9bfcce01DAD6] = 42914416333155802602;
    amounts[0x8bfad1E073b7DAE77DEC8768eA7dB33b1411455D] = 35372282851268647632391;
    amounts[0x2E0932c9F0599a21E816F259E6BEDcC4416E8f0f] = 82168665319643298091865;
    amounts[0xdBa3C7141C797dAD1FdbaFB60e0Ca1B9230fc315] = 8062539785202031706987;
    amounts[0x4143be95b43510e3225fBfCECc29241A01f7Fdc5] = 97444261842805218054256;
    amounts[0xC901c3cEEF9773a659C8f0A9b7C20ae0bE7a7Ab4] = 1476421975791404251479;
    amounts[0x6075A2c53ca8Eb6f6486e00adD1BA01AED5E6609] = 27637678896421481186335;
    amounts[0x7867691308b7E398548be062FA85ecf901D8808F] = 1462107591223787271986;
    amounts[0x455Bb52c8fe5e9AD2F9D17682fAeEf0E804A3D2E] = 3898952877821357107935;
    amounts[0xf4863355974c48179cb0a2810A92414Ca1829cc6] = 40633314248496180543985;
    amounts[0x64e9f340A9C3A07892921C851384ef6d054b1725] = 18229659721744769917349;
    amounts[0x09D390e78FAa3ECA8C6e3c0bB3C6CbCAF679a44c] = 31558764125070771095675;
    amounts[0x5E6A931A2502Cfe6C3a82743c72EAdDa0B0409a3] = 59372083044591123892973;
    amounts[0xab7F540976890F9b8F7d7A6a42754454f1bA84b3] = 486830783233103369504;
    amounts[0xA57183bDF02D8f8b2a645E638eC229a81675e8fD] = 97380560987491591200194;
    amounts[0x16aD3f1c89ae9042f61e2437fB81736F5d3A60c4] = 9107646564326835520608;
    amounts[0x79320de2e3a2D1B644F655d990dc5A51CC91d74b] = 9839024769669411094448;
    amounts[0x58D8727635d948684050f57054006f8cc5b3ba44] = 135725541906647886337284;
    amounts[0x9eA57bc2D559e766956928A8D42A8322F29E6C73] = 298706368948075090627252;
    amounts[0x91544E0d0ee6361152f06891b52E778B3614d253] = 27709154149792934555551;
    amounts[0x2dAAfbCB69C136c94a4702411333860b50C79022] = 310460778727862498177636;
    amounts[0x44DA00f9edf2D02FA37Fa73Fbe3ee4DB5019f068] = 215675775939958690184299;
    amounts[0x279a7DBFaE376427FFac52fcb0883147D42165FF] = 24310751025116589768872;
    amounts[0xC49fec8e567Cb9acE07c07748b63A93434beA86d] = 862353280035321969819986;
    amounts[0xE23756866b46A6666D3FF9febE3d19c3868f22E1] = 102998549362577138975153;
    amounts[0x3975946B88eC92d111BDfA2A057f2A0Ceb55C315] = 30181968877876204905716;
    amounts[0x14124A17F69C199A29a34Ab72d0790E2A46F3E19] = 11296209274667207007140;
    amounts[0x8a2Ff4f48a2Aef354D96339946B03fD740293BcE] = 28673993525860235051038;
    amounts[0x2B83aC024B0a4Ba3f93776Cacb61D98310614aFE] = 3314981643889585732390;
    amounts[0xe09b7de7A52c3b1FeEC08A5A1ff8900b79252dE8] = 4865575335033651392614;
    amounts[0x8564DfE89F25F6609Af4FFbd1a57767c0f1471fD] = 11658124359844216773475;
    amounts[0x0EBAb19F412e1afD2B90842e5C632aa186a4f60d] = 97758375745412396225782;
    amounts[0xf14C5c02758dC98ac86b36060F2124F3BeB72ad3] = 51279489141150358857225;
    amounts[0x2a1e54aa64cc38D5A5dE48feaeC0D0579F6869E7] = 239824991039636379686995;
    amounts[0x58fb797fE7C1D578d8deac552662101843eF0C4f] = 118135481102065048795073;
    amounts[0x0Db5E7924d87d2EC27876882E7af911A58050Dd1] = 496867392798993911310;
    amounts[0x7A2BBe4c66f8fabD8cC1EdD2F985216dC70D0870] = 45821368782347518918064;
    amounts[0x44e59F7c598644A68975eF41Fed052362C4c8ed3] = 871013705833341327338342;
    amounts[0x4FCBD0c9C74AFDCD9Dc2855E46AC703cF115c119] = 46782406255799235708376;
    amounts[0xD157D6f9f904879D44D59bDa39503Da7E6BFa20a] = 2703493396742947809040;
    amounts[0x71eCa87165753cFc5C1ECa398E59cF7C8f642031] = 9718181637475382282505;
    amounts[0xfC9e7d92E48D1431AcE73dF02515383a4a92C950] = 18956344684405169908919;
    amounts[0xdf8d12A07540768032aa307D50aF6CB5F4e8c153] = 339417489614113932294248;
    amounts[0x29E5cb1721Fb2dA29bb00d0b816B9289Ee96b1e9] = 9795451720567510503636;
    amounts[0x59F45AED461cE1B2E003242b6F16300529b6dDf4] = 79372896745636032112536;
    amounts[0x1aD5F28a4775F8292eeDD3288fF760DD9E825D05] = 4367406992188437956155;
    amounts[0x790f3efDf9dC3C862E08C606f9bb9dF952A926Dc] = 1698911211856002353;
    amounts[0x12A1E8f498501c2CCE0967F8b9717b28492fC668] = 86164735349349857736253;
    amounts[0x1B5a75086461D7896250f236B9433e7379Dc7FDB] = 3065949683715730237099;
    amounts[0xcd7C44cEa43eAac0178599063F5054687b3ea262] = 4437339859347658782598;
    amounts[0x71F12a5b0E60d2Ff8A87FD34E7dcff3c10c914b0] = 96175897124177481816366;
    amounts[0xF9D594DAcDf73982fbA8e2711C8728909F8D1205] = 97105601386203990643;
    amounts[0x8FD789c80296E3cFf5e8AF033838Dc70fe93d4fe] = 131275220149285430697241;
    amounts[0x8cCAf951C46899Aa11E96435261C271c3E5Ba963] = 197699049008353832282028;
    amounts[0xC61ACb8C89fd37ea82E72BA7d0f6359b11a18F05] = 127008871627363456785403;
    amounts[0x18b47fab4b893B6F38b655598457916157B22D6C] = 204514724377832760304367;
    amounts[0x66679D4ee3794Ca6a696070dC6ca92a93Df396EA] = 3054135801717446907882;
    amounts[0x0246b0a279Dd8466EcBA9b3b0aF5F51076763e09] = 2991396326139657728484;
    amounts[0x2b11b02F5B32056af20cDf8a45D4F680B303B3a3] = 14302582838537449458174;
    amounts[0xaDd528E4b48ac854DfaD1E79Ad6af2E7524AF26D] = 13273942028883050641090;
    amounts[0x35f1cC527BA6dE307106a2F8A8D169bcd314e2E7] = 426253345587507334270822;
    amounts[0x8B2dAF0A57ccB9E0604c661C44Af7503c851c55f] = 3494057611492817591116;
    amounts[0xdAEce07a8796fb0cD6c0A6381F005566Fa2a4a6e] = 2669884733201068618943;
    amounts[0xCbc6E88d1524315BA34B91Af4bCeB642323D9221] = 32709275844681463896723;
    amounts[0x296C2D4daaEf7b105ea4482a842e1Cc882583547] = 560849783480408254427;
    amounts[0xebDBCebE9aD1506B3361c21e86322f341a6aB623] = 6112550019720194337448;
    amounts[0x8c061Fc4625Ab8244ef1B9Bee7004F5f791F4dB9] = 415675561537358144658664;
    amounts[0xC99D1e8E91F5Be830Fc20739FF5FCae08f2c32C4] = 61982396643068049814698;
    amounts[0xC892b9C6192F024f9436654a13307bcF82c2fe5c] = 4728074507703632732997;
    amounts[0xd8f343e184f0DBE0314b0eE45aA9fC113acA57f9] = 3321913822983160727363;
    amounts[0x9843aFF0063E009043e313106DE4d3445F1c17e5] = 339495851313515067943;
    amounts[0xa1A0e93b1C2F12e2EF35e099b86e9a9ff6a734ea] = 14553247355746201247112;
    amounts[0x69E6717964273A4b031242BfcC904469ED7171dd] = 246079;
    amounts[0x3DE025CF38E843490388a761540bD3F155249873] = 71391714352671874140920;
    amounts[0x30cA2d6cf43BB6397f6e161aB21a363D14F19329] = 106724259520518115197243;
    amounts[0xC0F9e8De7cE5ad40979de08b6b746BA47Ca608cC] = 56985654704089040168465;
    amounts[0xEeff6fd32DeaFe1a9d3258A51c7F952F9FF0B2Ce] = 347735154277305153550600;
    amounts[0xBBDE1E05d96c5C4F7e377D5EaEd21Cac08A92945] = 2513712370002603237741;
    amounts[0x019cD07A77cA09c5f57666411c5bb87B4f9C04aa] = 10640812150909761259402;
    amounts[0xC59a0ca431216F10cD5C11831b9628182FA3ac3E] = 497992660381335349071;
    amounts[0x02062B8727CDde62Cd784382C60D738FCDBB736d] = 1015675148760994595468;
    amounts[0x6298c723dfC6FC60Fe3c914B344BDFBc7F720Fdf] = 57217178633591659794937;
    amounts[0x17BfbB16B3E67065D0c72E62391eBAfb85e87094] = 49097342112712263640;
    amounts[0x30ED5773E9c1023A266483D7860a2B19fA4c736C] = 176906249885388756648471;
    amounts[0x937D9eEc5E66fF49905e68AD143EF384d327fCD6] = 6953806775216192050502;
    amounts[0x85d14B5B709573c275B1cA9C1686Cc120E9E715F] = 97511829416622487094711;
    amounts[0x6DaE698478C129DD1d680AC383937F24b65a222a] = 1216249939908792517516;
    amounts[0x5356df73b293BD9c6e8eFD22C99833391EF8821A] = 52260329019495678034969;
    amounts[0x751B1D5235aa34Ed5243c57D9313c67AC386EC08] = 8102124223616282786116;
    amounts[0x4E9163F55e208E3a89dF230e2E7BE8B62e6743Ce] = 808728179859000252273;
    amounts[0xCbD6b0DeE49EeA88a3343Ff4E5a2423586B4C1D6] = 57525906612336417928445;
    amounts[0xD5472c60b7CA053a97000BDB6eff3C0CF32b9616] = 159713739476559409785945;
    amounts[0x186cf5714316F47BC59e30a850615A3f938d7D79] = 749630135860889838411852;
    amounts[0x3c229864378b3B0adF98aE247Ca33986AED8EC1E] = 19095178391658239975570;
    amounts[0x2898e036DcAa7a94eA96761193Cbe6C54d587bC5] = 26855543937639808804881;
    amounts[0x01B590B256dCb6300fe43FA2c629Dd9fD2838eD4] = 3533881150505271173922;
    amounts[0x557aD892cC457ffEF0737055D65D90c8De928694] = 114102846779457272489793;
    amounts[0x29AaB297a1cAA0BD91DB246CEF439d1Ef92E96Bc] = 6789068593487800984584;
    amounts[0xb92667E34cB6753449ADF464f18ce1833Caf26e0] = 2425412959747000348754;
    amounts[0xC8C8Ea2588D9E26A69c2fa56C09C7e274b72D8A0] = 9973038101479661324066;
    amounts[0x1d5e8B375B2F41b9AAC79d64ea1Fa113D08f41CB] = 1655455325981490368854;
    amounts[0x5924544A57e26b52231597aaa5E0374748C0a127] = 881919850077063667688;
    amounts[0x4063c9AdA6758eb625d01BAa49c008a8555F989A] = 98233086929806826152;
    amounts[0x690Eb09378CAC699B0ab2B09C6e6032C43d31D34] = 11759522564535176340824;
    amounts[0xA2490947b30258b522B7D6fD8Fabec2d21c42D57] = 8498511822174552056658;
    amounts[0xbeBCF6cDDcE5B5a494d7ce051AE3688A925bd10B] = 37853500824869521363063;
    amounts[0xa99f8656271bd54871639D7B1D20912263CC68E0] = 24266041247993470823514;
    amounts[0x7b36c434223B00AC272cF1F40F1acbB15683d392] = 5601676992100276408502;
    amounts[0xc843b210B7f1F8B52E9965528176f796E5d63B32] = 1940996517619694168134;
    amounts[0xb61d3430bD827B8c9a04e3F99896cCBa674080Da] = 44965166934023481059136;
    amounts[0xC697B16a7a2576B8df3918EC955D182b4a7C5ff8] = 185457729300745595407768;
    amounts[0xe0DEAf75A52CC9D1d7838C2338aDeaFe49bb80a2] = 17958732068459611204924;
    amounts[0x4795237e09BF7bFF7b6fb3D42466e2917F571223] = 48669354322969422245052;
    amounts[0xDD6Fc573CF73701aa31834644E245d9fb5BF906d] = 400121648490201818869342;
    amounts[0xfb17199BB361dAED5B8dF4E0d263f2f6CB990C50] = 154548477502573874874963;
    amounts[0x71e7Bf91e1DAEF8cc7421f3AD36837976364C113] = 92869467310381632289707;
    amounts[0x7c68F34B9D0D9f60d3BE8Aa828605E567cBeb3c6] = 170875155543637415377744;
    amounts[0x424685f9DF711A6D519f13D043894d7Ab0E6AA6F] = 245385855861845693956731;
    amounts[0xEe2319094bBB69c3DF5f1d2E5Ef62fD2F20030a1] = 204223269322480115667;
    amounts[0x5321B0508d162B6325A2E19c9B82911D87eA6525] = 38848597992514153609776;
    amounts[0x3F231AF0806fe97eA13867B50F24D9681A61a3BB] = 2591638923101675531179;
    amounts[0xB65889aCEFB18ccBc9214aAfDC08a96548D7Ce9f] = 43572399185184666330369;
    amounts[0x32e03aea9aE7f3DcCA4F04Bd5A9465253D51a493] = 233132389800345723272757;
    amounts[0xc2023feF67A789da083D45c7aeF2813d68391BC6] = 138515598889519857993177;
    amounts[0xc193Ae16165BC02a79E7a374Ce604E08Ac5b59Cd] = 94818073571884720115525;
    amounts[0x8655392fb3a5d39b456115E2F85452b69E8A2D04] = 3412170000000000000000;
    amounts[0x058B10CbE1872ad139b00326686EE8CCef274C58] = 1;
    amounts[0x116a45D9CD43c16D3835d09C735a69BeFD447866] = 1;
    amounts[0x58CE475fa55f23A4847BE77A0C147fF0A0c2B8b3] = 100000000000000000010;
    amounts[0x183B6267cb9F985A8AA7Fc912672A21d644a4102] = 105675176389963321003500;

  }
  
  function claim() public {
    require(!reimbursed[msg.sender], "already reimbursed");
    require(amounts[msg.sender] > 0, "not claimable");
    require(ERC20(token).transfer(msg.sender, amounts[msg.sender]));
    reimbursed[msg.sender] = true;
  }
  
}
