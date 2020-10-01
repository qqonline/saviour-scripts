// SPDX-License-Identifier: MIT
// from file output/uni_eth_dai.json
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

contract Reimbursement {
  mapping (address => uint256) public amounts;
  mapping (address => bool) public reimbursed;

  address public constant token = 0xA478c2975Ab1Ea89e8196811F51A7B7Ade33eB11;

  constructor() public {
    amounts[0x907D9B32654B8D43e8737E0291Ad9bfcce01DAD6] = 4712651136830133124;
    amounts[0xe4989e7B39a21089B128908E1603fdC9939DBB78] = 84118016350385826571;
    amounts[0xf174ddA2267F5141c1D2d523c53751692CC6f322] = 33033131233651964626;
    amounts[0x5580bA66f8d6Dc71adB0CA1d1c6B3D142Ff7aACa] = 86570141835794442544;
    amounts[0xe957B0829C6Ae6ac461d7365b7927E1Ff604114b] = 31927629915906077365;
    amounts[0xbdA2aDdD7acf55c6a2d6B36a54bE22399D6BB7Bd] = 77472452783446178036;
    amounts[0x2ed7aFA17473e17Ac59908F088b4371D28585476] = 548425916230919684702;
    amounts[0xA40C9aEA142C036F1038d6A21ECDb30beB6cA51c] = 32695281939168680114;
    amounts[0x112bE8010AC3AE3Aac99490002555297438ac394] = 8253354883008490820;
    amounts[0xc0AFEF712a1341cA78dA145B2AFAd346E8C3574F] = 38478339969255573131;
    amounts[0xE9c2C98E2433CdFa0DfB18bB17DEcc46F6B4f769] = 41812161228026994047;
    amounts[0xe328Bac3266Da6Be02f73A173bDbC4211AD61d09] = 25101918929036529591;
    amounts[0x10D6d2e343281D388291A3e02f3293AaEdA67178] = 18036657115820277349;
    amounts[0x79C4213a328E3B4F1D87b4953C14759399dB25E2] = 141687344592110079416;
    amounts[0xB857270071C5Ac2384523a689E2Ec51D90974feD] = 49941214645048117143;
    amounts[0x3888F5A94560D6af334c82DC5D94C134870f9E78] = 186281483606835436865;
    amounts[0x596888345c9e3c6F7d0F4E5d8590941E2CAb52e8] = 190029849507578984520;
    amounts[0x05A1ff0a32bc24265BCB39499d0c5D9A6cb2011c] = 110712859524490430826;
    amounts[0x18B63a66947D3663315dDAA4e7ca273f1dF8657a] = 66818814433093809990;
    amounts[0xE8E8f41Ed29E46f34E206D7D2a7D6f735A3FF2CB] = 703519698329406337676;
    amounts[0xC180cCF8D26f368563c0DD5726198822F23D6403] = 80642984527416090749;
    amounts[0x140a824Fe0C013Aa969f681B5312ef5C3a39CDB4] = 7849227324162540729;
    amounts[0xa2c949a6c8ad9fa1F5BF0a08ba6b936cbeB0A620] = 16893717743461334783;
    amounts[0x90B2291CE87d0dEa35Fe51A48cDdECb67198FA5E] = 14925742522152089457;
    amounts[0x0d38fA1382F809e138BE003eD018229B83Eb9146] = 483818395933142704118;
    amounts[0x2Debdf4427CcBcfDbC7f29D63964499a0ec184F6] = 40680788319702122886;
    amounts[0x5668EAd1eDB8E2a4d724C8fb9cB5fFEabEB422dc] = 637866366267315227601;
    amounts[0xe7Bcea4695D4fcA7280745eaC80F287Bbe7e6a4A] = 32734576463508233907;
    amounts[0xD8854167F53A57abB2a05705C58733e8f1451b5b] = 2295101798862882337992;
    amounts[0x005183A81C819A89DA65dC4c9A347755fB43eA2a] = 96458869229439989267;
    amounts[0xbc4fEf6016Fbd9248375016617D4481f2c96d4Bc] = 714327333980916138934;
    amounts[0xb53F75d2B366936483F68cbb53cf99b4dAF83FE1] = 53471733623753560179;
    amounts[0x2e29CfC451853397Dc8C1b0f66D4Bb83fb2b8795] = 1858312056514486393541;
    amounts[0x071Ef7f7b9dbabA85Fd6dC9f9a9b10e71F00A69b] = 4982567849060847503;
    amounts[0xC617f7F0009c7DD0A8cbD83E0439a356919D6270] = 8352327136160988667;
    amounts[0x3D7FAB5EcBa07D933567cb9DE777c7DBac872867] = 157805740405589479858;
    amounts[0x07682BFb043d9fc0Bd8c5Ce238f51231F12F06E7] = 14665506603891038292;
    amounts[0x9E1dFbD763536255276cc08411651faa54d5C612] = 5238166410292888285;
    amounts[0x8c8cc19957eD10153D291b1678b05b8551573008] = 198049748845083263487;
    amounts[0xEa4A804FA891D5880605AB411FbB6EffbCaF54C9] = 332261462534144923978;
    amounts[0x0fc5418364a7dE0aCa014Cd24D88d95138d27325] = 52129063449186297857;
    amounts[0x7Fc2F133807e2cc899c655122616B02493848B0d] = 24035833215795578570;
    amounts[0x05671bdb0814488366C519c604d0aefDFEB55Dc6] = 349571637641986162838;
    amounts[0x7780E86699e941254c8f4D9b7eB08FF7e96BBE10] = 2322682637520109367670;
    amounts[0x79D93cbf3583E62dD3EdBDDd1ee1121F8B07af81] = 10104014815745113354706;
    amounts[0x32af619771cD8B39a4f15CB9a4f10c664e9E39D9] = 403900562636158787956;
    amounts[0x1751dA90AC42069CF39B996AD277c55f18DD3a33] = 423617326527153973719;
    amounts[0xAAdAF3178430bBeeE0FA778E5a7dF4FA585D7d9f] = 226410002513451296752;
    amounts[0x27eAB7D3Ce4c84B9AfB0324dEb7c56BD72FC2FA0] = 1860063649957832903584;
    amounts[0xeda01f549Cad25f3847ce90d807c57e6F2949Bb4] = 35914413182947491855;
    amounts[0xd3B2a586180c9e306b38848D31e82F9E17D76F0C] = 15202221486666119430;
    amounts[0x4bF47f60ADb303F0C8c5b1c0D172354D050f1751] = 457283029272562517541;
    amounts[0x230e7F448F6EBc7C4433CCE03ee92EEB81681a2c] = 202012922894668525142;
    amounts[0x654ccc508186540E30669E10B9F68c7495d57C9b] = 600189352672054586812;
    amounts[0xe519f4cd2803BA53A40E6377E82406e548418660] = 2186664718322402249988;
    amounts[0xF9e11762d522ea29Dd78178c9BAf83b7B093aacc] = 20895134851518112026094;
    amounts[0x76Da9F88e63a85Ba8BFA19F3821D5A271753D3dc] = 3605048183652029796;
    amounts[0x334FF7580eE92bb13D744cd309925560877122a1] = 114442897365285385749;
    amounts[0xCe34448192A400305b948c3719Bd9231806e8c0B] = 122875041638589391338;
    amounts[0xFd65aa6012625B5044b76DdcaF1Da2A16b198DeC] = 16313293309662230269;
    amounts[0xdd7Bdfc451Edc8A9FBFdf015E072789c11B8b0c1] = 2013594926325724493;
    amounts[0x4E9163F55e208E3a89dF230e2E7BE8B62e6743Ce] = 67095977149754124851;
    amounts[0xc6E4Ad3ccdfC65687D2d60a454a8bdDc1F4d6c06] = 29021240790667431376;
    amounts[0x87885AaEEdED51C7e3858a782644F5d89759f245] = 71407886924631133499;
    amounts[0xa335AfCa0a16A8747d9A20747dd310F6c203D9dA] = 7518780715495323359;
    amounts[0xe1f5C3E4F4AD829d976821778c63F776b00A61d8] = 17865468365529634622;
    amounts[0xC555347d2b369B074be94fE6F7Ae9Ab43966B884] = 6968450235323146730;
    amounts[0x2FBb88EC97C4fFC513c837C566d801B368AA671E] = 32120520234492875816;
    amounts[0xC901c3cEEF9773a659C8f0A9b7C20ae0bE7a7Ab4] = 42035474253145908306;
    amounts[0xf7b80fb88571F63824D138CAb71e21487777991d] = 220989747730119190768;
    amounts[0xAcDB30e0Faa07f274687aCeAA41Ecf3dC2a26747] = 687817126019660125484;
    amounts[0x7A6A3F23F355081F92D64C8F19dA6fC315b3FA9d] = 16569807112564459167;
    amounts[0xD04403aaACAC36837faAb3d5c3110C6327EF1302] = 33814345316749530925;
    amounts[0x259Af9A30cd456D0D614e60BEb54E15824A85a1B] = 87809617945096326958;
    amounts[0x2E1440D9fB2930Ea27B469ab699e1a973EeCd562] = 8072543338076154542;
    amounts[0xC6D9F798AC7d130E51F241F8f3E95961e21e171C] = 157377683145941810602;
    amounts[0x97C96EaA506d4B6a0C4d27363d4C157625571132] = 75553266115860603048;
    amounts[0x9735A2921F85476c5023b91aAc6f991a9bE2698C] = 2338141436856852082016;
    amounts[0x623007DFd55313C2a8485e1458cd95EF761A63f6] = 252109353772562377878;
    amounts[0x1a164aD9450fe9369cB4749Ec51bBf59eae4C8B8] = 9512572709994599922044;
    amounts[0x2923Be587904F3034FFAB36C86c495Df3C21Bc97] = 40094711502616163855;
    amounts[0xdaC071eDBe067499281F1272cf39F4CCB1e50ac8] = 5816910994267429520585;
    amounts[0x331c37F833b6929199704c0c49Cdf4903DE13799] = 2277991165601516965160;
    amounts[0x016078A5e18D9a2A4698e8623744556F09a9Ca15] = 1343703277380292995414;
    amounts[0xd86D99a6e29C78Ca3D1027fFf6d927bE545Acf0a] = 28330551304600485392;
    amounts[0x5583347e299dfE16247224797704e093cAee28A1] = 836512162784610601733;
    amounts[0x856565Db827588a88780454863F98A4A323E13Aa] = 2562066359605063628503;
    amounts[0xE5B2124767F10D21F643Db08E4eBf0f17250d582] = 16485180688749898073;
    amounts[0xb7d49ADB031d6DBDF3E8e28F21C6Dd3b6f231cD5] = 846110974283134331178;
    amounts[0x6f9BB7e454f5B3eb2310343f0E99269dC2BB8A1d] = 206104339258655565920;
    amounts[0x91F8390Fa3485B372a95A26Bd59F1c175D200D25] = 65957676505308106884;
    amounts[0x47FEA52a4b79954fEdE50EE07b3F5d22696c8586] = 96528803914519141442;
    amounts[0x709530610A9beA2A5c90E7452a3057153F4a3A67] = 8135916187962713351;
    amounts[0x851497cf9B1362858C095CdD577B506d24F57336] = 6293263848936919427;
    amounts[0xcfc579300D3e8016c70147a37c48cC6467dAEE98] = 48652597926952297429;
    amounts[0x1bB7BA2e4104d68448567e75912C329fe9fA9204] = 1006761910869300254673;
    amounts[0x0a75728f3A2697045e8C62c7c4Be4597C2E7C254] = 262835806716375395882;
    amounts[0x13bbb69C3C2E4358A1c012E057D5Fe4B56E55513] = 201105231575785081939;
    amounts[0xf2e66768A8469A48E2eF282b006cD886147b4CB0] = 179107247186616809061;
    amounts[0x69b38da50A977Dc61C7571c9DC8192Ea1A884DCB] = 228724422532108065755;
    amounts[0x7b5c7755DFFc97Bf44677A084b591C38Bf894aBF] = 55882921429400644743;
    amounts[0x09173487b272311Edda01F45f97911aEB6aBd602] = 1467779534217665877431;
    amounts[0x196C3a943748504d695413167Fc3EB77c0832aDE] = 6223591602089333471873;
    amounts[0xc0819E1e01204BCB9CB5a0a3Be826afedAd6EDEf] = 9693670540136108829221;
    amounts[0x486fed1AE14C3D1Bc48F16345f42913d89588275] = 45186009039818444581;
    amounts[0x779ee773a45c0834EF325182999614ebD2AC5aA1] = 290580114747173337338;
    amounts[0x0be5149120375A4B5ba59352D55173C9B0283C3d] = 1006228008891977359;
    amounts[0xE173cC94d4755b72eB9196Cf50DbcD2Cba54e348] = 210480332918725867736;
    amounts[0x3464Af71d0b2E70E4B16a772B8FFBe7c7b82bf4b] = 2118206311832791579629;
    amounts[0x4599747dbF0c53B2dEBaD02d97549d2c2EDd84Ed] = 7261494005114601948;
    amounts[0x848887741B3e38233Cd858c5dD7B48Ca9197FC08] = 24513153806646691686;
    amounts[0xF694F85775A12e62fc6d8A9a48C99552E2e55133] = 6985918346162950615;
    amounts[0x27eaf5158DaAF5AE6c3E1494Fc53fB37A158F131] = 28898689996600098463;
    amounts[0x04552387B25b81B5b1C1bC04deF4f612E2085C38] = 41665456343187864930;
    amounts[0x2a6F85D90e74276Fe179Edf4345a55aeD46b37a4] = 1239549888274439719476;
    amounts[0x8D7C663100006083A4051C041d537377fC02b8E6] = 1648122218064331309727;
    amounts[0x1eccd61c9fa53a8D2e823A26cD72A7efD7D0E92e] = 3484637536053367899994;
    amounts[0xaD73c9dbC6865e18683F64D0d98852304AdB7c88] = 119376923026503472512;
    amounts[0x68e845717eA2ae0Ca63E7B2c9f6052FE7397e96E] = 171386325874160021162;
    amounts[0x6D5C09Bcdd3eb4338aF878d0b33a89ae0C0Bf9F1] = 779965308919035026651;
    amounts[0x9FaCE78A611e257c707665A28CeEe658e93e2a59] = 1170959859511393149373;
    amounts[0xbeEbDAe2558779e2b714836673A907D6C5D237f0] = 8297128669656442290437;
    amounts[0x4C28B7a52Cf9B44b7f775a0660fB09C41694EE7b] = 8906112976875038119;
    amounts[0x14fE97cC572a1Af9dD8Ce65f23Fc9eeA8f1e3aAf] = 62399295442717206394;
    amounts[0xB3D0204E133b24B455d49d9F87b6D1c605435ACC] = 313064510387221507352;
    amounts[0xFBb05840f992396e1Aaaa34A6d25CCcE86a27559] = 1575116782014032217;
    amounts[0xe254f0EFc830BDFAaDe07EbC99A1B355530bb625] = 63865587366618230372;
    amounts[0x1e121993b4A8bC79D18A4C409dB84c100FFf25F5] = 63140563826335860543;
    amounts[0xa703862d21E18A391278ae472cC2A87d34e082F6] = 991338101825220697749;
    amounts[0xb58723910C3A2110A8459E92A95f53f9854f16c9] = 2789841045359381418;
    amounts[0x1c4FDdb75f34a01E2699759656ba1121b5F532bC] = 6400471554704433014;
    amounts[0x387F1CE80bdED97d6B16e2CaCabF00Ccea20f056] = 13635144447776676648;
    amounts[0xB30452beCa9c462bC6773582c9e0d70Cc60E7321] = 82881235829145552290;
    amounts[0xE87a10d5B212D169CCBC9a50Cf5E23DD3da27cb6] = 17438718138489152955;
    amounts[0xC5Fe6e367742Af4d3A545d073DD310fa4842CD95] = 8024520436984888542;
    amounts[0x42E50118db781b7E46aa021fdBb78640F18f6387] = 345010212446604931403;
    amounts[0x6ab791754298D6D6d7C182DC1572126B4eD24897] = 31761698958211866322;
    amounts[0x173507742563BcB3dC67Ec80B1F5757FF9747E69] = 8157634423304263151866;
    amounts[0xeDDC7Ed53e44FA94c6C03a61428873bFb78462Ce] = 2767677725270380999;
    amounts[0x1182E9633e5D27B56cbf95ADF534A10060D1c1DF] = 428033461292685122202;
    amounts[0x3a3355805181ba5752cB52CEBE8C95c0F3ED3d61] = 7931579015201787030;
    amounts[0x88ee5532815DDd0cd009A556F44b42322083f193] = 1271680738601284131009;
    amounts[0x1B72Bac3772050FDCaF468CcE7e20deb3cB02d89] = 1190918804475805049749;
    amounts[0x799592b12ff0B5d485fe07b09520d459750472d0] = 65268212067840966877;
    amounts[0x983130D9948224262F90090a471bDF5CFF140869] = 2651789066676259010238;
    amounts[0x8783CeBE5155aDf8B603C32dAAC78F18E3bAA675] = 91015085247205773969;
    amounts[0xAA615C281D256bc3947f114f1290Cc0C520CD850] = 30676623205759371871018;
    amounts[0x26a46f0D81C7D72E86d95A8dcB031bccF220dc3c] = 3174570611666227674;
    amounts[0x4e7CD3458CdA9c75C39C40b4393108141ba0e2f7] = 11563799268530071914;
    amounts[0x5af17F7522C9Ff3700984673E0cAC4754bb2b793] = 23456399457145797483;
    amounts[0x0B48897CF03c0566D85491120a87c3Df8fa95810] = 4371407318510672565;
    amounts[0x599ED10fDeA23E5c968ea1dE7832011dbC7c9b22] = 129698716346673643001;
    amounts[0x3A21D56586Abb5AF9f3feB0D408A523a64C75dF0] = 12002998705527912417;
    amounts[0xEd3f0b5236f3d645b77e7983191833E3b8C1Fc50] = 451765203539123;
    amounts[0x6e3De06dc8c9FC460fB5bC30FAf9c973663aF1D1] = 4550403883046204322;
    amounts[0x92cF3cEF67F7e5Ca21918c3BE96ed905ECC54170] = 427044179429295881709;
    amounts[0x7F0f5AB22ffcF98a9E46dCf80CcBF27B36B93A28] = 322468790861970906474;
    amounts[0x059a8677D45A51490AD3eCA47dC5AA02be0D696A] = 64004463366523803696;
    amounts[0x877E0a86D0b55af0cFFDd5dfefd9800dD533751f] = 14361965006104537346;
    amounts[0x75FccfeB73783F042b847e6586Ed418F871251A3] = 11982041227716221;
    amounts[0xf1ca4Bf4C325C3078Ec25299601A519eBc6BEA6D] = 9912794161417595458;
    amounts[0x22fc579C3845b7f4016fD3A0f5AaFf31205dB66C] = 3244935428536847610;
    amounts[0x99578468f2d3fE0C247E8B27e2b966386f02b9dd] = 7807775537901585913;
    amounts[0xb92667E34cB6753449ADF464f18ce1833Caf26e0] = 69829484583759723629;
    amounts[0x7a2611B4b14D14c6d57C39daC5B02cb15Ef5Eef6] = 15626963193189566707;
    amounts[0x6bCAA539AB97dB627967C4bCFfe83572895F6638] = 2214292270369387304;
    amounts[0xCa12E8644C302B131467B3035aBA346ACf513076] = 944398106038365910;
    amounts[0x403089B876128B97012AEe31e3f91B4f6CfEBEde] = 4479635336484585505;
    amounts[0xBA0A0c93c138947121E85D4673d5C72B844a1091] = 6345860292300332753;
    amounts[0x641fA065689F9424913267F810bBE29e9D16FE71] = 23750204990558073094;
    amounts[0xc527173Fe89F869247e1fD9317abFC109cb751a7] = 7176758155735703572;
    amounts[0xf1BF075eAB208D76225Ff0e1c059CC9DF03c96A7] = 99042334808397211793;
    amounts[0x0429C8D18b916dFFa9d3Ac0bC56D34D9014456ef] = 80129030180204015180;
    amounts[0x7aa9D4015150DaB34850D298D90FCb7C69A4b1bf] = 110714803382671564900;
    amounts[0x675EA5214249049C43DeB7915A47a0850F174006] = 4866803737637061513;
    amounts[0x4263203D36416C17038B76c8cfC1a6a89Fef2DAE] = 19678773949213135810;
    amounts[0xF04099B30d233AF32FB6a906024eAfD21cf4d697] = 2903864226234090385;
    amounts[0x43edCBE5be576B5FdAC57e3ab552B36a256bCBA7] = 12280146708449889795;
    amounts[0x1d9E87682310AC1d9B5737E3D1C4eF9794f45Ca3] = 238430199494579164237;
    amounts[0xd8f343e184f0DBE0314b0eE45aA9fC113acA57f9] = 278092416083648600296;
    amounts[0xdd1dF77B43653cc56e0CbF5309Edd83aFb7b681F] = 3555712306309339557784;
    amounts[0x8aBf9BDEBa66ce480387710a8aEDcC372625Ae0b] = 2748405040720440055635;
    amounts[0x28a996BE66Ebe3b51B02165932592824cDBeFB9d] = 224515681267382025944;

  }
  
  function claim() public {
    require(!reimbursed[msg.sender], "already reimbursed");
    require(amounts[msg.sender] > 0, "not claimable");
    require(ERC20(token).transfer(msg.sender, amounts[msg.sender]));
    reimbursed[msg.sender] = true;
  }
  
}
