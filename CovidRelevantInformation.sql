
--Retrieve Population Percentage that has had Covid Vaccine and how much of population of country has been reached by vaccination on percentage.
Create View PercentageVaccinatedPopulation as
With CTE_Vacunancion (Continent,Location,Date,Population,new_vaccinations, RollingVaccinated) 
as (
	Select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations, 
	CAST(Sum(vac.new_vaccinations) Over (Partition by dea.Location Order by dea.Location, dea.date)as float) as  RollingVaccinated
	From CovidDeaths as Dea
	Join CovidVaccinations as Vac
		on Dea.location = Vac.location
		and Dea.Date = Vac.date
	where dea.continent is not Null
)
Select *, (RollingVaccinated / Population) * 100 as PercentageVaccinationPop
From CTE_Vacunancion



