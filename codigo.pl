
%Vehicle catalog (Part 1)
vehicle(toyota, corolla, sedan, 2015, 3200).
vehicle(ford, escape, suv, 2018, 4000).
vehicle(chevrolet, aveo, suv, 2012, 1500).
vehicle(hyundai, elantra, sedan, 2016, 2800).
vehicle(nissan, sentra, sedan, 2017, 3500).
vehicle(kia, sportage, suv, 2019, 5200).
vehicle(mazda, 3, hatchback, 2015, 2900).
vehicle(honda, civic, sedan, 2013,2200).
vehicle(bmw, serie3, sedan, 2011, 4800).
vehicle(toyota, coralla, suv, 2016, 5000).


%Part 2!
%Filter vehicles by type and budget
findall((Make, Reference, Year, Price), (vehicle(Make, Reference, suv, Year, Price), Price =< 4000), VehiclesWithinBudget),
write(VehiclesWithinBudget).
%Filter vehicles by make 
findall((Make,Reference),vehicle(Make,Reference,Type,Year,Price),Inventory).



 meet_budget(Type, Budget) :- 
 vehicle(_, _, Type, Price, _), 
 Price =< Budget.

%Case 1
findall(( Reference, Year, Price), (vehicle( toyota, Reference, suv, Year, Price), Price =< 6000), VehiclesWithinBudget).


%Case 2
bagof((Type,Year),vehicle(Ford,_,Type,Year,_),Lista).

%Case 3
generate_report(Make, Type, Budget, Result) :- 
    findall((Make, Type, Price),
            (vehicle(Make, Reference, Type, Year, Price),
             Price =< Budget),
            AllVehicles),

    % Ordenar por precio (más barato primero)
    predsort(comparar_por_precio, AllVehicles, SortedVehicles),

    % Seleccionar vehículos hasta no exceder el límite
    Max is 10000,
    seleccionar_vehiculos(SortedVehicles, Max, Seleccionados, Total),

    % Resultado final
    Result = result(Seleccionados, Total).

% Comparador para ordenar por precio
comparar_por_precio(Delta, (_, _, Precio1), (_, _, Precio2)) :-
    compare(Delta, Precio1, Precio2).

% seleccionar_vehiculos igual que antes
seleccionar_vehiculos([], _, [], 0).

seleccionar_vehiculos([(Make, Type, Price) | Resto], Max, [(Make, Type, Price) | Seleccion], Total) :-
    Price =< Max,
    NuevoMax is Max - Price,
    seleccionar_vehiculos(Resto, NuevoMax, Seleccion, TotalResto),
    Total is Price + TotalResto.

seleccionar_vehiculos([(_, _, Price) | _], Max, [], 0) :-
    Price > Max.


 