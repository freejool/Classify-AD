clear,clc
test_result = [];
sum = 0;
sum1 = [];

for i = 1:1:100

    for i = 1:1:48
        a = [0.320225447	3.005097912	0.374604055	1.60916555	2.547273184	0.325463668	2.232756196	0.357045621	0.354674	0.44113
            0.132521719	3.837387902	0.220928939	0.91436106	2.519650955	0.157051087	2.101416622	0.255542755	0.240576	0.332355
            0.092730835	2.609213755	0.366856988	1.84740877	2.209037593	0.099363448	2.590386694	0.306744	0.303992	0.43382
            0.361080855	3.62702422	0.281539903	1.01825523	2.653009171	0.367160273	1.893824502	0.385832727	0.378899	0.383667
            0.44435057	3.562350731	0.313094467	1.12135041	2.611805158	0.440837092	2.062727707	0.341857702	0.338343	0.426074
            0.456693709	3.194368751	0.399541009	1.81653023	2.840277664	0.4568768	2.255791307	0.445783794	0.444436	0.44557
            0.093795054	3.247769629	0.330337104	1.35910058	2.527882888	0.104886555	2.247493422	0.165816873	0.163902	0.422737
            0.412268102	4.040450832	0.309278527	1.22737968	2.827259781	0.390480821	2.367552688	0.482346654	0.487321	0.428512
            0.294244409	3.405605964	0.335077522	1.13217306	2.56751015	0.292666416	1.977344732	0.424864918	0.41964	0.444396
            0.323415786	4.032268743	0.278775895	0.807971358	2.755677568	0.328822969	1.722300358	0.428144217	0.418071	0.408304
            0.336414546	3.943162859	0.282459983	0.793561578	2.649562194	0.342364063	1.748817783	0.449392289	0.439809	0.419855
            0.30425182	3.922824386	0.290526085	0.93542695	2.724867989	0.318404443	1.933289775	0.336289257	0.327369	0.416727
            0.361986101	3.695091014	0.28671488	1.19517922	2.717556689	0.383963114	2.179472269	0.305275	0.303029	0.386311
            0.400519907	4.318266946	0.267216876	0.806505	2.777175417	0.427271597	1.916001824	0.463916481	0.454966	0.412168
            0.272836506	3.459431292	0.343797245	1.29266536	2.801235576	0.280062585	1.965204057	0.43103379	0.42728	0.424557
            0.150920436	3.252531356	0.283212315	1.32921875	2.561552524	0.16466807	2.133185506	0.180348024	0.179986	0.35741
            0.082006693	2.716834302	0.329835174	1.63931394	2.211477442	0.089818186	2.484187499	0.261659592	0.258838	0.405051
            0.40680787	4.058885601	0.278644432	0.909498	2.814998841	0.41696042	1.864683408	0.400309	0.39587	0.399403
            0.36996457	5.038633036	0.230073655	0.720885873	3.084786797	0.414181822	1.894986488	0.387288898	0.382162	0.370886
            0.129289493	2.824344239	0.269209168	1.50160706	2.380556781	0.133025546	2.107550581	0.356170863	0.352858	0.318737
            0.326990157	3.934714843	0.277627419	0.97074616	2.775402044	0.317789709	1.920764373	0.558866799	0.556957	0.392789
            0.218100414	4.220405873	0.271622684	0.927514255	2.895586525	0.231868896	1.931739079	0.47164759	0.46409	0.392059
            0.287759215	4.09686017	0.27705516	0.925716639	2.751489251	0.314690483	2.023149739	0.473089397	0.458349	0.411454
            0.242998973	4.774371986	0.235459335	0.596358538	3.001732064	0.249345961	1.496917702	0.484834343	0.477149	0.373242
            0.318702281	3.056720868	0.360305383	1.51727843	2.403614355	0.323945054	2.444817126	0.322188556	0.319884	0.457066
            0.106347948	3.298172475	0.298723312	1.35586333	2.697361843	0.106852909	2.02121935	0.460264444	0.458748	0.364583
            0.471328348	3.441567428	0.326257647	1.50170255	2.787487711	0.478149726	2.24647859	0.480642796	0.479427	0.399947
            0.658582389	3.684489837	0.345088543	1.39048481	2.710191486	0.678910405	2.456942403	0.354168594	0.359983	0.458092
            0.18297632	3.513847228	0.345632867	1.44439304	2.739484241	0.177882246	2.31907454	0.493036389	0.486041	0.438674
            0.39976579	3.707792671	0.316553219	1.22614908	2.87627356	0.4115596	2.010061052	0.523515403	0.518088	0.406271
            0.156614453	3.068379375	0.311271015	1.35332334	2.488109231	0.160806533	2.059403508	0.254491508	0.249396	0.38329
            0.339895099	3.681183501	0.303975578	1.00394523	2.591930476	0.343038855	2.014072028	0.439262927	0.431231	0.431679
            0.440448791	3.632759171	0.332724575	1.29735732	2.696995887	0.459019851	2.305546005	0.41599831	0.413569	0.443872
            0.404564917	3.94893741	0.281152677	1.12135744	2.958423515	0.427750121	1.947121569	0.54415369	0.538698	0.371576
            0.309945911	3.157566657	0.34107271	1.48334897	2.51018496	0.315842891	2.327213661	0.414209634	0.411887	0.427562
            0.102116436	2.607343764	0.391696771	1.80482042	2.18312703	0.107430929	2.588426212	0.312029392	0.309015	0.468536
            0.557656646	4.118592054	0.317853471	1.37578797	3.354580391	0.59369046	2.013021412	0.305245161	0.303521	0.383425
            0.288764417	4.742701998	0.305195039	1.20954883	3.593712648	0.335020756	2.003402875	0.493792355	0.493274	0.390345
            0.189336598	2.941690563	0.36095511	1.48962498	2.523246043	0.192753704	2.033155233	0.312765837	0.309628	0.421218
            0.316908419	4.62092333	0.248457167	0.660586178	2.817424193	0.333993713	1.742329674	0.330073267	0.319746	0.403594
            0.409025818	4.059698503	0.288247805	0.926853	2.999790755	0.420646044	1.69072482	0.387389153	0.391873	0.389213
            0.291126758	3.676236799	0.293616599	0.926741898	2.516105128	0.300071504	1.959224947	0.406372696	0.390332	0.429619
            0.264762074	3.450443134	0.320223266	1.22674882	2.594555874	0.27052855	2.150668685	0.451654702	0.443799	0.425462
            0.409161955	3.873551189	0.363135154	1.54472649	2.862635557	0.415007421	2.646088262	0.491669923	0.49193	0.473155
            0.242455587	4.05421599	0.35803935	1.53966546	3.050966637	0.286947529	2.523554317	0.494741261	0.492873	0.453876
            0.31888938	3.234232688	0.324713554	1.37750864	2.616205001	0.329433075	2.096165077	0.268457621	0.260131	0.400772
            0.538043857	3.861019037	0.357990702	1.62986767	3.07882594	0.583125708	2.418423426	0.453589201	0.454157	0.433444
            0.014676659	3.020440447	0.364650593	1.67456079	2.39999322	0.023710834	2.63671604	0.448071897	0.443658	0.457606

            ];
        A = randsample(48, 1, false);

        if (A > 24)
            a2 = a;
            a2(A, :) = [];
            Train_labels = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
            Train_Data = a2;
            TestData = a(A, :);
            classifier = fitcsvm(Train_Data, Train_labels); %train
            test_labels = predict(classifier, TestData); % test
            

            if (test_labels == -1)
                sum = sum + 1;
            end

            %test_labels = [test_labels;-1];
            %test_result = [test_result,test_labels]
        else
            a2 = a;
            a2(A, :) = [];
            Train_labels = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
            Train_Data = a2;
            TestData = a(A, :);
            classifier = fitcsvm(Train_Data, Train_labels); %train
            test_labels = predict(classifier, TestData); % test

            if (test_labels == 1)
                sum = sum + 1;
            end

            %test_labels = [test_labels;1];
            %test_result = [test_result,test_labels]
        end

    end

    sum1 = [sum1, sum];
end