const jwt=require('jsonwebtoken');

const auth =async (req,res,next) => {
try{
    const token =req.header('x-auth-token');
    if(!token){
        return res.status(401).json({message:"No auth token, access denied   "})
    }

    const verify =jwt.verify(token ,'passwordkey')
    if(!verify){
        return res.status(401).json({message:"Token verification failed authorization denied "})
    }
    req.user=verify.id; 

    req.token=token;
    next();
}
catch(e){
    res.status(500).json({error: e.message});
}


};
module.exports = auth;