-- all comments and rating for branch with current user @ top
select comment.branch_id,
       comment.user_id,
       rate.rating,
       comment.comment,
       comment.time,
       (select count(liked.user_id)
        from browse_packagecommentreact liked
        where liked.post_id = comment.id
          and liked.liked = true)       as nlikes,
       (select count(disliked.user_id)
        from browse_packagecommentreact disliked
        where disliked.post_id = comment.id
          and disliked.disliked = true) as ndislikes
from browse_branchcomment comment
         left join browse_branchrating rate on rate.branch_id = comment.branch_id and
                                               rate.user_id = comment.user_id
where comment.user_id = 1
  and comment.branch_id = 2
UNION
DISTINCT
select comment.branch_id,
       comment.user_id,
       rate.rating,
       comment.comment,
       comment.time,
       (select count(liked.user_id)
        from browse_packagecommentreact liked
        where liked.post_id = comment.id
          and liked.liked = true)       as nlikes,
       (select count(disliked.user_id)
        from browse_packagecommentreact disliked
        where disliked.post_id = comment.id
          and disliked.disliked = true) as ndislikes
from browse_branchcomment comment
         left join browse_branchrating rate on rate.branch_id = comment.branch_id and
                                               rate.user_id = comment.user_id
order by time desc;


-- avg Branch rating
select avg(rating) as avg_rating
from browse_branchrating
where branch_id = 1;


-- avg Restaurant rating
select avg(rating) as avg_rating
from browse_branchrating join accounts_restaurantbranch
on browse_branchrating.branch_id = accounts_restaurantbranch.id
where accounts_restaurantbranch.restaurant_id = 1;

