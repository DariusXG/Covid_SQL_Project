select * 
from NashvilleHousing

select saledateconverted, convert(Date, saledate)
from NashvilleHousing

Alter Table NashvilleHousing
ADD SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = Convert(date, Saledate)

-- Populate Property Address Data

select propertyaddress
from nashvillehousing

select *
from NashvilleHousing
where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL( a.propertyAddress, b.PropertyAddress)
from NashvilleHousing a
Join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

Update a
set propertyaddress = ISNULL (a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
Join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-----------------------------------------------------------

-- Breaking out Address into individual columns (Address, City, State)

select PropertyAddress
from NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', propertyaddress) -1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', propertyaddress) +1, LEN(PropertyAddress)) as Address
from NashvilleHousing


Alter Table NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', propertyaddress) -1)


Alter Table NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', propertyaddress) +1, LEN(PropertyAddress))


Select OwnerAddress from NashvilleHousing


select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as OwnerAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)as OwnerCity,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) as OwnerState
From NashvilleHousing


Alter Table NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


Alter Table NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

Alter Table NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

----------------------------------------------

--Change Y and N to Yes and No


Select Distinct(SoldAsVacant), count(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
from NashvilleHousing

UPDATE NashvilleHousing
Set SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END

-------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	Order by
	UniqueID
	) Row_num

	From NashvilleHousing
	)
DELETE
From RowNumCTE
where Row_num > 1
--order by PropertyAddress

--------------------------------------------


-- Delete Unused Columns

select * from NashvilleHousing

Alter table NashvilleHousing
drop column OwnerAddress, TaxDistrict, propertyAddress

Alter Table NashvilleHousing
drop column saledate