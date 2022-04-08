MATCH (token:AnnotatedToken)<-[:HAS_TAG]-(i:Information)
  WHERE token.lemma IN $tags
WITH count(i) as total_tf
MATCH (token:AnnotatedToken)<-[:HAS_TAG]-(i:Information)
  WHERE token.lemma IN $tags
OPTIONAL MATCH (i)<-[:IS_ASSIGNED_TO*0..2]-()-[:IS_CONTAINED_IN*0..1]->()-[:RELATES_TO*0..1]->()-[:BELONGS_TO]->(area:Area)
WITH area, count(i) AS intersection, total_tf
RETURN area, intersection * 1.0 / total_tf AS p
ORDER BY p DESC;
