indexing
	description: "Class that can be inherited by classes which use categories, like item or channel."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class
	CATEGORIES
	
feature -- Access

	categories: SORTABLE_TWO_WAY_LIST[CATEGORY]
			-- Categories list containing category items
			
feature -- Setter

	set_categories (category_list: like categories) is
			-- Set categories with a new category list
		require
			non_void_categories: category_list /= Void
		do
			categories := category_list
		ensure
			categories_set: categories.is_equal (category_list)
		end
		
feature -- Status
	
	has_categories: BOOLEAN is
			-- Are there any categories?
		do
			Result := categories.count > 0
		end
		
feature -- Basic operations

	add_category (category: CATEGORY) is
			-- Add a category item
		require
			non_void_category_item: category /= Void
		do
			categories.extend (category)
		end
		
	remove_category (category: CATEGORY) is
			-- Remove a category item
		require
			non_void_category_item: category /= Void
		do
			categories.start
			categories.prune (category)
		end

feature -- Sort

	sort_categories_by_title is
			-- Sort categories by title
		do
			categories.set_order (create {CATEGORY_SORT_BY_TITLE[CATEGORY]})
			categories.sort
		end
		
	sort_categories_by_domain is
			-- Sort categories by domain
		do
			categories.set_order (create {CATEGORY_SORT_BY_DOMAIN[CATEGORY]})
			categories.sort
		end
		
	reverse_sort_categories_by_title is
			-- Reverse sort categories by title
		do
			categories.set_order (create {CATEGORY_REVERSE_SORT_BY_TITLE[CATEGORY]})
			categories.sort
		end
		
	reverse_sort_categories_by_domain is
			-- Reverse sort categories by domain
		do
			categories.set_order (create {CATEGORY_REVERSE_SORT_BY_DOMAIN[CATEGORY]})
			categories.sort
		end
		
feature {CATEGORIES} -- Initialize `categories'

	initialize_categories is
			-- Initialize `categories'
		do
			create categories.make
			categories.compare_objects
		end
		
invariant
	non_void_categories: categories /= Void

end -- class CATEGORIES
